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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    //STEP 2
    func configureCell(img: UIImage?, post: Post) {
        likeRef = DataService.instance.REF_USERS.child("test_user").child("likes").child(post.postKey)
        
        self.post = post
        self.likesLabel.text = "\(post.likes)"

        if post.imgUrl != nil {

            let imageRef = REF_STORAGE_POSTS.child("images").child("\(post.imgUrl!)")

            print("img ref", imageRef)
            imageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                    print("could not download image")
                    print(error.debugDescription)
                } else {
                    let img: UIImage! = UIImage(data: data!)
                    self.postImageView.image = img
                    TimelineViewController.imageCache.setObject(img, forKey: self.post.imgUrl!)
                }
            }
        } else {
            print("no image")
            self.postImageView.hidden = true
        }
        
        
        
       likeRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeButton.selected = false
                print("not liked")
            } else {
                self.likeButton.selected = true
                print("liked")
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
