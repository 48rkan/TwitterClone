//  Tweet.swift
//  TwitterClone
//  Created by Erkan Emir on 26.06.23.

import Foundation
import FirebaseFirestore

struct Tweet {
    let tweetID            : String
    var text               : String
    var likes              : Int
    let retweets           : Int
    let time               : Timestamp
    let ownerUID           : String
    let ownerUserName      : String
    let ownerFullName      : String
    var liked              : Bool
    let ownerProfilImageUrl: String
    
    init(tweetID: String,dictionary: [String:Any]) {
        self.tweetID             = tweetID
        self.text                = dictionary["text"]                as? String ?? ""
        self.likes               = dictionary["likes"]               as? Int        ?? 0
        self.retweets            = dictionary["retweets"]            as? Int        ?? 0
        self.time                = dictionary["time"]                as? Timestamp ?? Timestamp(date: Date())
        self.ownerUID            = dictionary["ownerUid"]            as? String     ?? ""
        self.ownerUserName       = dictionary["ownerUserName"]       as? String     ?? ""
        self.ownerFullName       = dictionary["ownerFullName"]       as? String     ?? ""
        self.liked               = dictionary["liked"]               as? Bool       ?? false
        self.ownerProfilImageUrl = dictionary["ownerProfilImageUrl"] as? String     ?? ""
    }
}

