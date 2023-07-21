//  ActionViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 20.07.23.

import Foundation
import FirebaseAuth

class ActionViewModel {
    
    var user   : User
    var tweetID: String
    var isCurrentUser: Bool {  Auth.auth().currentUser?.uid == user.uid }

    var type: [ActionSheetOptions] {
        var result = [ActionSheetOptions]()
        
        if isCurrentUser {
            result.append(.delete(tweetID))
        } else {
            user.isFollowing ? result.append(.unfollow(user)) : result.append(.follow(user))
        }
        result.append(.report)
        return result
    }
    
    //MARK: - Lifecycle
    init(user: User,tweetID: String) {
        self.user    = user
        self.tweetID = tweetID
    }
}

enum ActionSheetOptions {
    case follow  (User)
    case unfollow(User)
    case report
    case delete(String)
    
    var description: String {
        switch self {
        case .follow  (let user): return "follow @\(user.username)"
        case .unfollow(let user): return "unfollow @\(user.username)"
        case .report: return "Report post"
        case .delete: return "Delete post"
        }
    }
}
