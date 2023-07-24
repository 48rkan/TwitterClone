//
//  TweetViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 12.07.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TweetViewModel {
    
    //MARK: - Properties
    var replies     = [Tweet]()
    var selectedUser: User?
    var tweet       : Tweet
    var callBack    : (()->())?

    init(tweet: Tweet) {
        self.tweet = tweet
        checkTweetIfLiked()
        fetchReplies()
        fetchSelectedUser()
    }
    
    var user   : User   { selectedUser ?? User(dictionary: [:]) }
    var tweetID: String { tweet.tweetID }
    
    func checkTweetIfLiked() {
        TweetService.checkTweetIfLiked(tweet: tweet) { isLiked in
            print(isLiked)
            self.tweet.liked = isLiked
        }
    }
    
    func fetchSelectedUser() {
        UserService.fetchSelectedUser(userUid: tweet.ownerUID) { user in
            self.selectedUser = user
            
            UserService.checkIfUserIsFollowed(uid: user.uid) { isExist in
                self.selectedUser?.isFollowing = isExist
            }
        }
    }
    
    func fetchReplies() {
        ReplyService.fetchReplies(tweetID: tweet.tweetID) { replies in
            self.replies = replies
            self.callBack?()
        }
    }
}
