//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 22.06.23.

import UIKit

class RegisterViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
    
    var selectedImage: UIImage?
    
    var formIsValid: Bool {
        email?.isEmpty    == false &&
        password?.isEmpty == false &&
        fullName?.isEmpty == false &&
        userName?.isEmpty == false
    }
    
    var configBackgroundColor: UIColor { formIsValid ? .brown : .white}

    func registerUser(credential: AuthCredential, completion: @escaping (Error?) -> ()) {
        
        AuthService.registerUser(credential: AuthCredential(email: credential.email,
                                                            password: credential.password,
                                                            fullname: credential.fullname,
                                                            username: credential.username,
                                                            profileImage: credential.profileImage)) { error in
            completion(error)
        }
    }
}
