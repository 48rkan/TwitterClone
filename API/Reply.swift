//
//  Reply.swift
//  TwitterClone
//  Created by Erkan Emir on 15.07.23.

import Foundation
import FirebaseFirestore

struct Reply {
    let comment            : String
    let userUid            : String
    let username           : String
    let userProfileImageUrl: String
    let timestamp          : Timestamp
    let fullName           : String
    
    init(dictionary: [String:Any]) {
        self.comment             = dictionary["comment"]             as! String
        self.userUid             = dictionary["userUid"]             as! String
        self.username            = dictionary["username"]            as! String
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as! String
        self.timestamp           = dictionary["timestamp"]           as! Timestamp
        self.fullName            = dictionary["fullName"]            as! String

    }
}

extension Reply  {
//    var profileImageURL: String    { userProfileImageUrl }
//    var ownerUID       : String    { userUid           }
//    var userName       : String    { username        }
//    var times          : Timestamp { timestamp     }
//    var text           : String    { comment     }
//    var tweetID        : String    { ""        }
//    var isLiked: Bool { false }

}
