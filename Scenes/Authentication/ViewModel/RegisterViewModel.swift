//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 22.06.23.

import UIKit

class RegisterViewModel {
    var selectedImage: UIImage?

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
