//
//  MoviesTableViewController.swift
//  World Movies
//
//  Created by mino on 7/1/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit
import  AFNetworking

class MoviesTableViewController: UITableViewController {
    
    
    @IBOutlet var TableViewList: UITableView!
    
    var movies :[NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewList.dataSource = self
        TableViewList.delegate = self
        
        
        FetchMovies()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
         return movies?.count ?? 0
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//           }

    
    func FetchMovies ()
    {
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
                    print("response: \(responsedictionary)")
                    self.movies = responsedictionary["results"] as! [NSDictionary]
                    
                    self.TableViewList.reloadData()
                }
                
                
            }
        })
        task.resume()
        
    }
    
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewList.dequeueReusableCell(withIdentifier:"MovieCell", for: indexPath) as! MovieCell
        
      let movie = movies! [indexPath.row] as NSDictionary
       
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
      // let posterPath = movie ["poster_path"] as! String
      
    //   cell.Title.text = title
     //  cell.Desc.text = overview
        
    //   let baseURL = "https://image.tmdb.org/t/p/w500"
    //  let imageURL = NSURL(string: baseURL + posterPath)
           //    cell.Poster.setImageWith(imageURL! as URL)
      
      // cell.textLabel?.text = title     
        //print("row \(indexPath.row)")
        return cell

    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
