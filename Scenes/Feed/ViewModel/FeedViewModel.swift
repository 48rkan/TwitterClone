//  FeedViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import Foundation

class FeedViewModel {
    
    var profilimage  : String?
    var callBack     : (()->())?
    var tweets       = [Tweet]()
    var reloadCallBack: (()->())?
    
    init() {
        fetchAllTweets()
        fetchUser()
    }

    func fetchUser() {
        UserService.fetchUser { user in
            self.profilimage = user.profilimage
            print(user.isCurrentUser)
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
