//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 05.07.23.
//

import Foundation

class ExploreViewModel {
    
    var users         = [User]()
    var filteredUsers = [User]()
    var callBack: (()->())?
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        UserService.fetchAllUsers { users in
            self.users = users
            self.callBack?()
        }
    }
}
