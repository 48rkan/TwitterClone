//
//  AuthServıce.swift
//  TwitterClone
//
//  Created by Erkan Emir on 22.06.23.

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct AuthCredential {
    var email: String
    var password: String
    var fullname: String
    var username: String
    var profileImage: UIImage
}

struct AuthService {
    
    static func logUserIn(email: String,
                          password: String,
                          completion: @escaping (AuthDataResult?,Error?) ->()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            completion(authDataResult,error)
        }
    }
    
    static func registerUser(credential: AuthCredential, completion: @escaping (Error?) -> ()) {
        
        ImageUploader.uploadImage(image: credential.profileImage) { imageUrl in
            
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                if error != nil { completion(error) }

                guard let uid = result?.user.uid else { return }
                
                let data: [String:Any] = [
                    "email"      : credential.email,
                    "password"   : credential.password,
                    "fullname"   : credential.fullname,
                    "username"   : credential.username.lowercased(),
                    "profilimage": imageUrl,
                    "uid"        : uid
                ]
                
                Firestore.firestore().collection("user").document(uid).setData(data,completion: completion)
            }
        }
    }
}
