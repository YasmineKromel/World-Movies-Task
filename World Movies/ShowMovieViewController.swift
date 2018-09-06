//
//  ShowMovieViewController.swift
//  World Movies
//
//  Created by mino on 7/2/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseAuth



class ShowMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: IBoutlets
    @IBOutlet weak var CommentTableViewList: UITableView!
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var usrNameP: UILabel!
    @IBOutlet weak var userPicP: UIImageView!
    
    
    @IBOutlet weak var movietitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!    
    @IBOutlet weak var moviePoster: UIImageView!
    
    //MARK: Variables
    
    var tit:String!
    var des:String!
    var url:URL!
    
    var userName:String!
    var ucomment:String!
    var selectedindex:Int!
    var CommentsData = [CommentDataModel]()
    
    //Firebase data reference
    let dbref = Database.database().reference().child("UserComments")
    
    
    //MARK:ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
       
        movietitle.text = self.tit
        movieDesc.text = self.des
        moviePoster.setImageWith(url)
        
        usrNameP.text = userName
        CommentTableViewList.dataSource = self
        CommentTableViewList.delegate = self
       
       GetComments()
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableViewList Functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       
        return CommentsData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = CommentTableViewList.dequeueReusableCell(withIdentifier:"CommentViewCell", for: indexPath) as! CommentViewCell
        
        let comment = CommentsData[indexPath.row]
        
        cell.userName.text = comment.AuthUser
        cell.commentLbl.text = comment.User_Comment
        return cell
        
    }
    
    //MARK: AddComment
    
    @IBAction func AddComment(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Comment",
                                      message: "Add a comment",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your comment here..."
        })
        
        let saveAction = UIAlertAction(title:"Save", style: .default, handler: { action in
            
            if let ucomm = alert.textFields?.first?.text {
                
                self.ucomment = ucomm
                print("Your comment:Posted\(self.ucomment)")
                
                self.PostComment()
               // self.GetComment()
                // self.GetComments()
            }
        })
            
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)

        
    }
    
    // MARK: PostComment function to DB
    
    func PostComment()
    {
        dbref.childByAutoId().setValue(["User":self.userName,"PostId": self.selectedindex ,"Comment": self.ucomment ])
        print("Post Done")
    }
    
    
    // MARK: GetComment function from DB
    func GetComments()
    {
        // Query data
         dbref.queryOrdered(byChild:"PostId").queryEqual(toValue:selectedindex).observe(DataEventType.value, with: { (snapshot:DataSnapshot) in
            
            //observing the data changes (Get All Data)
       // dbref.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.CommentsData.removeAll()
                
                //iterating through all the values
                for comment in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let commentObject = comment.value as? [String: AnyObject]
                    let commUser  = commentObject?["User"]
                    let postId  = commentObject?["PostId"]
                    let comm = commentObject?["Comment"]
                    
                    //creating artist object with model and fetched values
                    let comment = CommentDataModel(AUser: commUser as! String, pID: postId as! Int, UComment: comm as! String)
                    
                    //appending it to list
                    self.CommentsData.append(comment)
                    print("Get Comments")
                }
                
                
                //reloading the tableview
                self.CommentTableViewList.reloadData()
            }
            else{
                print("No values")
            }
        })
       
        
   }
    
    /*
  // Post comments to JsonPlaceholder
    func PostComment()
    {
       // let UName = Auth.auth().currentUser
     //   let comm = ucomment
     //  let movietit = tit
//        
//        if UName != nil && comm != nil && movietit != nil
//        {
//        
//        let UComm:[String:AnyObject]=["User": UName! ,
//                                       "MTitle": movietit! as AnyObject ,
//                                        "comm":comm! as AnyObject ]
//        let DBRef = Database.database().reference(withPath: "PostComments")
//            DBRef.child("Comments").childByAutoId().setValue(UComm)
//        }
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/comments"
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "POST"
        var castedindex = String(Int(selectedindex))
        
        print(castedindex)
        print (tit)
        print( userName)
        print (ucomment)
        
        
        let newTodo: [String: Any] = ["postId":castedindex,"name":tit,"email":userName, "body": ucomment ]
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            todosUrlRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }
    
    */
    // Get comments by JsonPlaceholder
//    func GetComment()
//    {
//        // Set up the URL request
//        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/posts/2/comments/501"
//        guard let url = URL(string: todoEndpoint) else {
//            print("Error: cannot create URL")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        
//        // set up the session
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        
//        // make the request
//        let task = session.dataTask(with: urlRequest) {
//            (data, response, error) in
//            // check for any errors
//            guard error == nil else {
//                print("error calling GET on /todos/1")
//                print(error!)
//                return
//            }
//            // make sure we got data
//            guard let responseData = data else {2
//                print("Error: did not receive data")
//                return
//            }
//            // parse the result as JSON, since that's what the API provides
//            do {
//                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
//                    as? [String: Any] else {
//                        print("error trying to convert data to JSON")
//                        return
//                }
//                // now we have the todo
//                // let's just print it to prove we can access it
//                print("The todo is: " + todo.description)
//                
//                // the todo object is a dictionary
//                // so we just access the title using the "title" key
//                // so check for a title and print it if we have one
//                guard let todoComment = todo["body"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoComment)
//            } catch  {
//                print("error trying to convert data to JSON")
//                return
//            }
//        }
//        task.resume()
//
//    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    


    
 

}


