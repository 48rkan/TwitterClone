//
//  TweetHeaderViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 12.07.23.

import Foundation

struct TweetHeaderViewModel {
    var tweet: Tweet

    var caption      : String { tweet.text                }
    var profileImage : String { tweet.ownerProfilImageUrl }
    var fullNameLabel: String { tweet.ownerFullName       }
    var userNameLabel: String { "@\(tweet.ownerUserName)" }
    var time         : String { tweet.time.detailedTime() }
}
