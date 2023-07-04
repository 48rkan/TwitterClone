//
//  ProfileHeadeViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 01.07.23.
//

import Foundation

class ProfileHeaderViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var buttonTitle: String { user.isCurrentUser ? "Edit Profile" : "Follow" }
    
    var fullName       : String { user.fullname       }
    var userName       : String { "@\(user.username )"}
    var profileImageURL: String { user.profilimage    }
}
