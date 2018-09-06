//
//  MoviesViewController.swift
//  World Movies
//
//  Created by mino on 7/1/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK : IBOutlet

    @IBOutlet weak var TableViewList: UITableView!
    
    //MARK: Variables
    
     var  titleValue: String!
     var  overviewValue: String!
     var imageurlValue:URL!
     var userN:String!
     var movies :[NSDictionary]?
     var index:Int!
    
    //MARK : DidLoad_function
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TableViewList.dataSource = self
        TableViewList.delegate = self
        FetchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView Functions
    
  // count cells and return them
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return movies?.count ?? 0
     }
    
  // fill every cell in table view
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = TableViewList.dequeueReusableCell(withIdentifier:"MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies! [indexPath.row] as NSDictionary
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie ["poster_path"] as! String
        
        cell.Mtitle.text = title
        cell.Moverview.text = overview
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        cell.Mposter.setImageWith(imageURL! as URL)
        
        return cell

     }
    
    // perform an action when cell selected
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print("You selected cell #\(indexPath.row)!")
        
          self.index = indexPath.row
        // Get selected cell data
         let indexPath = TableViewList.indexPathForSelectedRow!
        let currentCell = (movies?[indexPath.row])! as NSDictionary
       
         titleValue = currentCell["title"] as! String
        overviewValue = currentCell["overview"] as! String
        
        let posterPath = currentCell["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        
        imageurlValue = imageURL as!URL
  
       performSegue(withIdentifier: "ShowMovieDetail", sender: self)

    }
    
    // MARK: fetch movies
    
    func FetchMovies ()
    {
        // apikey from TMDB
        let apiKey = "b0db9e2ab4f8352ff94e84dc1de01640"
        let Url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        
        let request = URLRequest(
            url:Url! as URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,timeoutInterval:10
        )
        
        let session = URLSession(
            
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue :OperationQueue.main
            
        )
        
        let task :URLSessionDataTask = session.dataTask(with: request,completionHandler:{(dataOrNil,reponse,error)in
            if let data = dataOrNil{
                if let responsedictionary = try!JSONSerialization.jsonObject(with:data, options: []) as? NSDictionary{
                    // To know if there is response or not
                   // print("response: \(responsedictionary)")
                    self.movies = responsedictionary["results"] as! [NSDictionary]
                    
                    self.TableViewList.reloadData()
                }
                
                
            }
        })
        task.resume()
        
    }
    
       
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destinationViewController.
         //Pass the selected object to the new view controller.
        if (segue.identifier == "ShowMovieDetail") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! ShowMovieViewController
            // your new view controller should have property that will store passed value
            viewController.tit = titleValue
            viewController.des = overviewValue
            viewController.url = imageurlValue
            viewController.userName = userN
            viewController.selectedindex = index
        }
    }
    

}
