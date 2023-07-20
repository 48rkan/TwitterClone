//  LoginViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 22.06.23.

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel {
    var email: String?
    var password: String?
    
//    if let email = viewModel.email, let passw = viewModel.password {
//        logInButton.isEnabled = true
//        logInButton.backgroundColor = .red
//    }
    
    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }
    
    var configBackgroundColor: UIColor {
        formIsValid ? .brown : .white
    }
    
    func logUserIn (email: String, password: String,completion: @escaping (AuthDataResult?,Error?) ->()) {
        AuthService.logUserIn(email: email, password: password) { result, error in
            completion(result,error)
        }
    }
}
