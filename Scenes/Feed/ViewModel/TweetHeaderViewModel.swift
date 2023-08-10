//
//  TweetHeaderViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 12.07.23.

import UIKit

class TweetHeaderViewModel {
    var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
}

extension TweetHeaderViewModel {
    var caption      : String { tweet.text                }
    var profileImage : String { tweet.ownerProfilImageUrl }
    var fullNameLabel: String { tweet.ownerFullName       }
    var userNameLabel: String { "@\(tweet.ownerUserName)" }
    var time         : String { tweet.time.detailedTime() }
    var isLiked      : Bool   { tweet.liked               }
    var likes        : Int    { tweet.likes               }
    
    var buttonImage: UIImage  { isLiked ? Assets.like_filled.image() : Assets.like_unselected.image() }
    
    var buttonTintColor: UIColor { isLiked ? UIColor.red : UIColor.black }
    
  
}
