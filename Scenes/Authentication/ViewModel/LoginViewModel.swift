//
//  LoginViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 22.06.23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel {
    
    func logUserIn (email: String, password: String,completion: @escaping (AuthDataResult?,Error?) ->()) {
        AuthService.logUserIn(email: email, password: password) { result, error in
//            print(error)
            completion(result,error)

        }
    }
}
