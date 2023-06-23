//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 23.06.23.
//

import Foundation

class FeedViewModel {
    
    var profilimage: String?
    var callBack   : (()->())?
    
    init() {
        fetchUser()
    }

    func fetchUser() {
        UserService.fetchUser { user in
            self.profilimage = user.profilimage
            self.callBack?()
        }
    }
}
