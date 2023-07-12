//
//  SearchCellViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 05.07.23.
//

import Foundation

class SearchCellViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var profileImage: String {
        user.profilimage
    }
    
    var userName: String {
        user.username
    }
    
    var fullName: String {
        user.fullname
    }
}
