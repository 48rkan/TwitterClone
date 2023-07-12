//  ProfileHeadeViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 01.07.23.

import Foundation

class ProfileHeaderViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowing ? "Following" : "Follow"
    }
    
    var fullName       : String { user.fullname       }
    var userName       : String { "@\(user.username )"}
    var profileImageURL: String { user.profilimage    }
    var followingCount : String { "\(user.statistic?.following ?? 0)"}
    var followersCount : String { "\(user.statistic?.followers ?? 0)"}

}
