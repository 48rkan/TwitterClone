//  ProfileViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 01.07.23.

import Foundation

class ProfileViewModel {

    var user: User
    var tweets = [Tweet]()
    var callBack: (()->())?
    
    init(user: User) {
        self.user = user
        fetchSelectedUserTweets()
        checkIfUserIsFollowed()
        fetchUserStatistic()
    }
    
    func fetchSelectedUserTweets() {
        TweetService.fetchSelectedUserTweets(userUid: user.uid) { tweets in
            self.tweets = tweets
            self.callBack?()
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { isExist in
            self.user.isFollowing = isExist
        }
    }

    func fetchUserStatistic() {
        UserService.fetchUserStatistic(uid: user.uid) { currentStat in
            self.user.statistic = currentStat
            self.callBack?()
        }
    }
}
