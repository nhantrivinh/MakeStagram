//
//  TimelineViewController.swift
//  MakeStagram
//
//  Created by AndAnotherOne on 6/24/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit
import Firebase


class TimelineViewController: UIViewController {
    
    var posts: [Post] = []
    static var imageCache = NSCache()
    
    @IBOutlet weak var tableView: UITableView!
    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 470.0
        self.tabBarController?.delegate = self
        
    }
    
    //Downloading from FIR
    //STEP 3
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear")
        
        DataService.instance.REF_POSTS.observeEventType(.Value, withBlock: { (snapshot) in
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    if snap.value != nil {
                        print(snap.value)
                        //Talk to firebase
                        let postDict = snap.value as! Dictionary<String, AnyObject>
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            }) { (err) in
                print(err)
        }
        
    }
    
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
            print("callback received")
            let post = Post(image: image)
            
            post.uploadPost()
        })
    }
    
}

extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        print(posts.count)
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostTableViewCell {
            var img: UIImage?
            
            if let url = post.imgUrl {
                img = TimelineViewController.imageCache.objectForKey(url) as? UIImage
            }
            
            cell.configureCell(img, post: post)
            
            return cell
        } else {
            return PostTableViewCell()
        }
    }
    
    
}
