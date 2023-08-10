//  MenuViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 03.07.23.

import UIKit

class MenuViewModel {
    var user    : User?
    var callBack: (()->())?
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.callBack?()
        }
    }
    
    var userName    : String { "@\(user?.username ?? "")" }
    var fullName    : String { user?.fullname ?? ""       }
    var profileImage: String { user?.profilimage ?? ""    }
}
