//  FeedViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import Foundation

class FeedViewModel {

    var tweets        = [Tweet]()
    var profilimage   : String?
    var callBack      : (()->())?
    var reloadCallBack: (()->())?
    var isCurrentUser : Bool?
        
    init() {
        fetchAllTweets { self.checkTweetIfLiked() }
        fetchUser()
    }

    func fetchUser() {
        UserService.fetchUser { user in
            self.profilimage = user.profilimage
            self.isCurrentUser = user.isCurrentUser
            self.callBack?()
        }
    }
    
    func fetchAllTweets(completion: @escaping ()->()) {
        TweetService.fetchTweets { tweets in
            self.tweets = tweets
            completion()
        }
    }

    func checkTweetIfLiked() {
        self.tweets.forEach { post in
            TweetService.checkTweetIfLiked(tweet: post) { isLiked in
                guard let index = self.tweets.firstIndex(where: { $0.tweetID == post.tweetID }) else { return }
                self.tweets[index].liked = isLiked
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.reloadCallBack?() }
    }
    
    func fetchSelectedUser(userUid: String,completion: @escaping (User)->()) {
        UserService.fetchSelectedUser(userUid: userUid) { user in
            completion(user)
        }
    }
}
