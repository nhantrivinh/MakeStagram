//
//  DataService.swift
//  MakeStagram
//
//  Created by AndAnotherOne on 6/25/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = FIRDatabase.database().reference()

let STORAGE = FIRStorage.storage()
let REF_STORAGE = STORAGE.referenceForURL("gs://makestagram-8cb5a.appspot.com")
let REF_STORAGE_POSTS = REF_STORAGE.child("posts")
let REF_STORAGE_IMAGES = REF_STORAGE.child("images")

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = URL_BASE
    private var _REF_POSTS = URL_BASE.child("posts")
    private var _REF_USERS = URL_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        get {
            return _REF_BASE
        }
    }
    
    var REF_POSTS: FIRDatabaseReference {
        get {
            return _REF_POSTS
        }
    }
    
    var REF_USERS: FIRDatabaseReference {
        get {
            return _REF_USERS
        }
    }
    
    var REF_UIDS: FIRDatabaseReference {
        get {
            let uid = _REF_USERS.child("uids")
            return uid
        }
    }
    
    var REF_USERNAMES: FIRDatabaseReference {
        get {
            let usernames = _REF_USERS.child("usernames")
            return usernames
        }
    }

    
}