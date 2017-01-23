//
//  PhotosViewController.swift
//  tumblr lab1
//
//  Created by zheng wu on 1/22/17.
//  Copyright © 2017 CodeMonkey. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var posts: [NSDictionary] = []
    var image: UIImage!
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = 240
     let  refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.loadMore), for: UIControlEvents.valueChanged)
        tableview.insertSubview(refreshControl, at: 0)
        
        loadMore()

    }
    
    func loadMore() {
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        // self.feeds = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.tableview.reloadData()
                    }
                }
        });
        task.resume()
        //UIRefreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let post = posts[indexPath.row]
        let timestamp = post["date"] as? String
        
        cell.celllabel.text = timestamp
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary]{
            // photos is NOT nil, go ahead and access element 0 and run the code in the curly braces
             let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                // URL(string: imageUrlString!) is NOT nil, go ahead and unwrap it and assign it to imageUrl and run the code in the curly braces
                
                 cell.cellImage.setImageWith(imageUrl)
            } else {
                // URL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
            }
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
        }
        //cell.celllabel?.text = "this is row \(indexPath.row)"
        return cell
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! PhotoDetailsViewController
        let cell = sender as! TableViewCell
        guard let image = cell.cellImage.image else{
            return
        }
        dvc.image = image
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* let post = posts[indexPath.row]
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary]{
            // photos is NOT nil, go ahead and access element 0 and run the code in the curly braces
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                // URL(string: imageUrlString!) is NOT nil, go ahead and unwrap it and assign it to imageUrl and run the code in the curly braces
                
               // cell.cellImage.setImageWith(imageUrl)
                //self.image = cell.cellImage.image
            } else {
                // URL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
            }
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
        }*/
        tableview.deselectRow(at: indexPath, animated:true)
    }
}

