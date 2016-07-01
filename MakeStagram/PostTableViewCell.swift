//
//  PostTableViewCell.swift
//  MakeStagram
//
//  Created by AndAnotherOne on 6/25/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var post: Post!
    var likeRef: FIRDatabaseReference!
    var downloadTask: FIRStorageDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postImageView.image = nil
        self.likeButton.selected = false
        self.likesLabel.hidden = true
    }
    
    //STEP 2
    func configureCell(img: UIImage?, post: Post) {
        
        likeRef = DataService.instance.REF_USERS.child("test_user").child("likes").child(post.postKey)
        
        self.post = post
        self.likesLabel.text = "\(post.likes)"

        if post.imgUrl != nil {
            if img != nil {
                self.postImageView.image = img
            } else {
                let imageRef = REF_STORAGE_POSTS.child("images").child("\(post.imgUrl!)")
                
                print("img ref", imageRef)
                
                downloadTask = imageRef.dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
                    if (error != nil) {
                        // Uh-oh, an error occurred!
                        print("could not download image")
                        print(error.debugDescription)
                    } else {
                        let img = UIImage(data: data!)!
                        self.postImageView.image = img
                        TimelineViewController.imageCache.setObject(img, forKey: self.post.imgUrl!)
                    }
                })
            }
            
        } else {
            print("no image")
            self.postImageView.hidden = true
        }
        
        let handle = likeRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.likesLabel.hidden = false
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeButton.selected = false
                
            } else {
                self.likeButton.selected = true
                
            }
        }) { (err) in
            print(err.debugDescription)
        }
    }
    
    @IBAction func moreBtnTapped(sender: AnyObject) {
        
    }
    
    @IBAction func likeBtnTapped(sender: AnyObject) {

        likeRef.observeSingleEventOfType(FIRDataEventType.Value, withBlock: { (snapshot) in
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeButton.selected = true
                self.post.adjustLikes(true)
                self.likeRef.setValue(true)
                print("not liked")
            } else {
                self.likeButton.selected = false
                self.post.adjustLikes(false)
                self.likeRef.removeValue()
                print("liked")
            }
            }) { (err) in
                print(err.debugDescription)
        }
        
        
    }

}
