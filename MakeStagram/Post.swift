//
//  Post.swift
//  MakeStagram
//
//  Created by AndAnotherOne on 6/25/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    private var _username: String!
    private var _imgUrl: String?
    private var _image: UIImage?
    private var _likes: Int!
    private var _postKey: String!
//    private var _postRef: String!
    
    var image: UIImage? {
        return _image
    }
    
    var imgUrl: String? {
        return _imgUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var username: String {
        return _username
    }
    
    var postKey: String {
        return _postKey
    }
    
//    var postRef: String {
//        return _postRef
//    }

    //initialize post
    //Good
    init(imageUrl: String?, username: String!) {
        self._image = image
        self._username = username
    }
    
    //download and parsing data
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imgUrl = dictionary["imageUrl"] as? String {
            self._imgUrl = imgUrl
        }
        
    }
    
    init(image: UIImage?) {
        self._image = image
    }
    
    func adjustLikes(addLike: Bool) {
        
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        //Save the new total likes to firebase
        DataService.instance.REF_POSTS.child("likes").setValue(_likes)
        
    }
    
    func uploadPost() {
        if let image = image {
            
            // 1
            guard let imageData: NSData = UIImageJPEGRepresentation(image, 0.1) else {return}
            
            let imageName = "imageName\(NSDate.timeIntervalSinceReferenceDate()).jpg"
            let imageRef = REF_STORAGE_POSTS.child("images/\(imageName)")
            
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
                print("background task begins")
            })
            
            
            let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                    print(error.debugDescription)
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    
                    guard let downloadURL = metadata!.downloadURL() else {
                        print("Nil download URL")
                        return
                    }
                    print("download url:", downloadURL)
                    print("image uploaded")
                    let imgUrl = downloadURL.absoluteString
                    
                }
                
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
                print("background task ended")
            }
        }
    }
    
}
