//  Tweet.swift
//  TwitterClone
//  Created by Erkan Emir on 26.06.23.

import Foundation
import FirebaseFirestore

extension Tweet: FeedCellProtocol {
    var profileImageURL : String    { ownerProfilImageUrl }
    var fullName        : String    { ownerFullName       }
    var userName        : String    { ownerUserName       }
    var times           : Timestamp { time                }
}

struct Tweet {
    let tweetID            : String
    let text               : String
    let likes              : Int
    let retweets           : Int
    let time               : Timestamp
    let ownerUID           : String
    let ownerUserName      : String
    let ownerFullName      : String
    let liked              : Bool
    let ownerProfilImageUrl: String
    
    init(tweetID: String,dictionary: [String:Any]) {
        self.tweetID             = tweetID
        self.text                = dictionary["text"]                as! String
        self.likes               = dictionary["likes"]               as! Int
        self.retweets            = dictionary["retweets"]            as! Int
        self.time                = dictionary["time"]                as! Timestamp
        self.ownerUID            = dictionary["ownerUid"]            as! String
        self.ownerUserName       = dictionary["ownerUserName"]       as! String
        self.ownerFullName       = dictionary["ownerFullName"]       as! String
        self.liked               = dictionary["liked"]               as! Bool
        self.ownerProfilImageUrl = dictionary["ownerProfilImageUrl"] as! String
    }
}

