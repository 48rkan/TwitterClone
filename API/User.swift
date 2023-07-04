//  User.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import Foundation
import FirebaseAuth

struct User {
    var email        : String
    var fullname     : String
    var username     : String
    var profilimage  : String
    var uid          : String
    var isCurrentUser: Bool   { return Auth.auth().currentUser?.uid == uid }
    
    var isFollowing = false
    
    init(dictionary: [String:Any]) {
        self.email       = dictionary["email"]       as? String ?? ""
        self.fullname    = dictionary["fullname"]    as? String ?? ""
        self.username    = dictionary["username"]    as? String ?? ""
        self.profilimage = dictionary["profilimage"] as? String ?? ""
        self.uid         = dictionary["uid"]         as? String ?? ""
    }
}
