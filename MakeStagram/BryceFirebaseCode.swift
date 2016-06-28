//
//  BryceFirebaseCode.swift
//  MakeStagram
//
//  Created by AndAnotherOne on 6/27/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import Foundation

//@IBAction func addButtonPressed(sender: AnyObject) {
//    let storage = FIRStorage.storage()
//    let storageRef = storage.referenceForURL("gs://socialmedia-96371.appspot.com")
//    let imageName = "image\(NSDate.timeIntervalSinceReferenceDate()).jpg"
//    let imagesRef = storageRef.child("postImages/\(imageName)")
//    
//    if let text = postTextField.text where text != "" {
//        if let image = imageSelector.image where imageAdded == true {
//            
//            let imageData = UIImageJPEGRepresentation(image, 0.3)!
//            
//            imagesRef.putData(imageData, metadata: nil) { metadata, error in
//                
//                if (error != nil) {
//                    print("ERROR: \(error.debugDescription)")
//                } else {
//                    
//                    // Metadata contains file metadata such as size, content-type, and download URL.
//                    guard let downloadURL = metadata!.downloadURL() else {
//                        print("downloadURL is Nil")
//                        return
//                    }
//                    let imageUrl = downloadURL.absoluteString
//                    self.postToFireBase(imageUrl)
//                }
//            }
//        } else {
//            self.postToFireBase(nil)
//        }
//    }
//}
//func postToFireBase(imageURL: String?) {
//    
//    var post: Dictionary<String, AnyObject> = [
//        "description": postTextField.text!,
//        "likes": 0
//    ]
//    
//    if imageURL != nil {
//        post["imageURL"] = imageURL!
//    }
//    
//    let firebasePost = DataService.sharedInstance.REF_POSTS.childByAutoId()
//    firebasePost.setValue(post)
//    
//    postTextField.text = ""
//    imageSelector.image = UIImage(named: "camera")
//    imageAdded = false
//    
//    tableView.reloadData()
//}
////This gets called in viewDidLoad
//func observeFirebaseForUpdates() {
//    DataService.sharedInstance.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
//        print(snapshot)
//        
//        //Clear array everytime it updates
//        self.posts = []
//        
//        //Data returned from Firebase as array of Snapshots
//        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
//            
//            for snap in snapshots {
//                print("SNAP : \(snap)")
//                
//                if let postDict = snap.value as? Dictionary<String, AnyObject> {
//                    let key = snap.key
//                    let post = Post(postKey: key, dictionary: postDict)
//                    
//                    self.posts.append(post)
//                }
//            }
//        }
//        
//        self.tableView.reloadData()
//    })
//    
//}