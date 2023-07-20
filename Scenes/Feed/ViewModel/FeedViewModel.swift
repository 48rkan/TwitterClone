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
        fetchAllTweets()
        fetchUser()
    }

    func fetchUser() {
        UserService.fetchUser { user in
            self.profilimage = user.profilimage
            print(user.isCurrentUser)
            self.isCurrentUser = user.isCurrentUser
            self.callBack?()
        }
    }
    
    func fetchAllTweets() {
        TweetService.fetchTweets { tweets in
            self.tweets = tweets
            self.reloadCallBack?()
        }
    }
    
    func fetchSelectedUser(userUid: String,completion: @escaping (User)->()) {
        UserService.fetchSelectedUser(userUid: userUid) { user in
            completion(user)
        }
    }
}
