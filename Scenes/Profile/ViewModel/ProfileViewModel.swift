//  ProfileViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 01.07.23.

import Foundation

class ProfileViewModel {
//    var uid: String
    var user: User
    var tweets = [Tweet]()
    var callBack: (()->())?
    
    init(user: User) {
        self.user = user
        fetchSelectedUserTweets()
    }
    
    
    func fetchSelectedUserTweets() {
        TweetService.fetchSelectedUserTweets(userUid: user.uid) { tweets in
            self.tweets = tweets
            self.callBack?()
        }
    }
    
//    var callBack: (()->())?
        
//    init(uid: String) {
//        self.uid = uid
////        fetchSelectedUser()
//    }
    
//    func fetchSelectedUser() {
//        UserService.fetchSelectedUser(userUid: uid) { user in
//            self.user = user
//            self.callBack?()
//        }
//    }
}

//class ProfileViewModel {
//    var uid: String
//    var user: User?
//
//    var callBack: (()->())?
//
//    init(uid: String) {
//        self.uid = uid
////        fetchSelectedUser()
//    }
//
//    func fetchSelectedUser() {
//        UserService.fetchSelectedUser(userUid: uid) { user in
//            self.user = user
//            self.callBack?()
//        }
//    }
//}
