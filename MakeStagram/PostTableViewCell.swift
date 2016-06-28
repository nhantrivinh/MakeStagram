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
        self.post = post
        self.likesLabel.text = "\(post.likes)"

        if post.imgUrl != nil {
            let imageRef = REF_STORAGE_POSTS.child("images").child("imageName.jpg")
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
        
    }
    
    func initObserver() {
        
    }
    
    
    
    @IBAction func moreBtnTapped(sender: AnyObject) {
        
    }
    
    @IBAction func likeBtnTapped(sender: AnyObject) {
        
    }

}
