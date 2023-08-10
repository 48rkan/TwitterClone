//  Notification.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import Foundation
import FirebaseFirestore
import FirebaseCore

// bir enum yaradacaiq , notification type adinda , cunki muhendislik meselelerinde hemise case'ler reqemlerle qeyd olunur.Mes: follow etmek 0 casesidir , post like etmek notification'u 1 casesidir , digeri 2 ve s.Yeni biz follow etmek meselesini eger databazaya qeyd etmek isteyirikse bunun ucun follow etti adinda bir string gondere bilmerik , ve ya dogru deyil , bunun ucun reqemlemelerden istifade edirik . mes eger type = 0 dirsa demeli , follow notificationdur 1 dirse digeri ve s..
enum NotificationType: Int {
    case like
    case follow
    case reply
    case retweet
    case mention
    
    var notificationMessage: String {
        switch self {
        case .like   : return " liked your post."
        case .follow : return " started following you."
        case .reply  : return " commented on your post."
        case .retweet: return " retweet on your post."
        case .mention: return " startedmention you"
        }
    }
}

// tutalim biri postunu like edib.Postu like edenin sekli olmalidir.Ve senin postunun image'si lazimdir ki , notification ekraninda cixsin.

struct Notification {
    let uid               : String
    let postImageUrl      : String? //optional- cunki follow olsa posta ehtiyac qalmir
    let postId            : String? //optional- cunki follow olsa posta ehtiyac qalmir
    let timestamp         : Timestamp
    let type              : NotificationType
    let username          : String
    let userProfilImageUrl: String
    let documentID        : String
    var userIsFollowed    = false

    
    init(dictionary:[String:Any]) {
        self.type               = NotificationType(rawValue: dictionary["type"] as! Int) ?? .like
        self.uid                = dictionary["uid"]                as! String
        self.postImageUrl       = dictionary["postImageUrl"]       as? String
        self.postId             = dictionary["postID"]             as? String
        self.timestamp          = dictionary["timestamp"]          as! Timestamp
        self.username           = dictionary["username"]           as! String
        self.userProfilImageUrl = dictionary["userProfilImageUrl"] as! String
        self.documentID         = dictionary["documentID"]         as! String
    }
}
