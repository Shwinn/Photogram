//
//  HomeViewController.swift
//  Photogram
//
//  Created by Ashwin Gupta on 3/21/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 500
        
        fetchData()
    }
    
    func fetchData(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            print(posts.count)
            return posts.count
        }
        else {
            print("0")
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = posts![indexPath.row]
        cell.captionLabel.text = post["caption"] as! String
        cell.captionLabel.sizeToFit()
        
        cell.postImageView.file = post["media"] as? PFFile
        cell.postImageView.loadInBackground()
        
        print("a cell")
        print(post["caption"] as! String)
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
