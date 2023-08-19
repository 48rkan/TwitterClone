//  ProfileViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 01.07.23.

import Foundation

final class ProfileViewModel {

    //MARK: - Properties
    var user: User
    
    private var tweets      = [Tweet]()
    private var likeTweets  = [Tweet]()
    private var replyTweets = [Tweet]()
    
    var successCallBack: (()->())?
    
    var type: ProfileFilterOptions = .tweets {
        didSet { self.successCallBack?() }
    }
    
    var currentDataSource: [Tweet] {
        switch type {
        case .tweets : return tweets
        case .replies: return replyTweets
        case .likes  : return likeTweets
        }
    }
        
    //MARK: - Lifecycle
    init(user: User) {
        self.user = user
        fetchSelectedUserTweets()
        checkIfUserIsFollowed()
        fetchUserStatistic()
        fetchLikes()
        fetchReplies()
    }
    
    //MARK: - Methods
    private func fetchLikes() {
        TweetService.fetchSelectedlikeTweet(user: user) { tweets in
            self.likeTweets = tweets
            self.successCallBack?()
        }
    }
    
    private func fetchReplies() {
        ReplyService.fetchSelectedReplies(user: user) { tweets in
            self.replyTweets = tweets
            self.successCallBack?()
        }
    }
    
    private func fetchSelectedUserTweets() {
        TweetService.fetchSelectedUserTweets(userUid: user.uid) { tweets in
            self.tweets = tweets
            self.successCallBack?()
        }
    }
    
    private func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { isExist in
            self.user.isFollowing = isExist
        }
    }

    private func fetchUserStatistic() {
        UserService.fetchUserStatistic(uid: user.uid) { currentStat in
            self.user.statistic = currentStat
            self.successCallBack?()
        }
    }
}
