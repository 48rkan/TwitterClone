//
//  User.swift
//  TwitterClone
//
//  Created by Erkan Emir on 23.06.23.

import Foundation
import FirebaseAuth

struct User {
    var email      : String
//    var password   : String
    var fullname   : String
    var username   : String
    var profilimage: String
    var uid        : String
    
    var isFollowing = false
    
    var askdjalkdjalsj = true
        
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(dictionary: [String:Any]) {
        self.email       = dictionary["email"]       as? String ?? ""
        self.fullname    = dictionary["fullname"]    as? String ?? ""
        self.username    = dictionary["username"]    as? String ?? ""
        self.profilimage = dictionary["profilimage"] as? String ?? ""
        self.uid         = dictionary["uid"]         as? String ?? ""
    }
}

