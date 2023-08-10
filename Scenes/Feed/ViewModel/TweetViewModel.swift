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

    //MARK: - Lifecycle
    init(tweet: Tweet) {
        self.tweet = tweet
        checkTweetIfLiked(tweet: tweet)
        fetchTweetsLikesCount(tweet: tweet)
        fetchReplies()
        fetchSelectedUser()
    }
    
    func checkTweetIfLiked(tweet: Tweet) {
        TweetService.checkTweetIfLiked(tweet: tweet) { isLiked in
            self.tweet.liked = isLiked
            self.callBack?()
        }
    }
    
    func fetchTweetsLikesCount(tweet: Tweet) {
        TweetService.fetchTweetsLikesCount(tweetID: tweet.tweetID) { count in
            print(count)
            self.tweet.likes = count
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

extension TweetViewModel {
    var user   : User   { selectedUser ?? User(dictionary: [:]) }
    var tweetID: String { tweet.tweetID }
}
