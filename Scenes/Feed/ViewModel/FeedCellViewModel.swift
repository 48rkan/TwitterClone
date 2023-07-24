//  FeedCellViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 26.06.23.

import Foundation
import FirebaseFirestore
import UIKit

class FeedCellViewModel {
    var items: Tweet
    
    init(items: Tweet) {
        self.items = items
        checkTweetIfLiked()
    }
    
    var fullName: String { items.ownerFullName  }
    var userName: String { " @\(items.ownerUserName)"  }
    var time    : String { " ∙ \(items.time.convertToRealTime())"}
    var callBack: (()->())?
    
    func checkTweetIfLiked() {
        TweetService.checkTweetIfLiked(tweet: items) { isLiked in
            self.items.liked  = isLiked
            self.callBack?()
        }
    }
    
    var buttonImage: UIImage { items.liked ? Assets.like_filled.image() : Assets.like_unselected.image() }
    
    var buttonTintColor: UIColor { items.liked ? UIColor.red : UIColor.black }}
