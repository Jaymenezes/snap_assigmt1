//
//  CollectionViewController.swift
//  movie_viewer
//
//  Created by user on 1/24/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit





class CollectionViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    
    var movies:[NSDictionary]?
    var filteredMovies : [NSDictionary]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Snap"
        searchBar.delegate = self
        
        
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
        
        
        // Do any additional setup after loading the view.
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            print("response: data fetched")
                            
                            self.movies = responseDictionary ["results"] as? [NSDictionary]
                            self.filteredMovies = self.movies
                            
                            
                            
                            
                            self.collectionView.reloadData()
                            
                    }
                }
                
        });
        task.resume()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
