//
//  UserService.swift
//  TwitterClone
//
//  Created by Erkan Emir on 23.06.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService {
        // bu yalniz movcud olan(1) useri bize verir.
    static func fetchUser(completion: @escaping (User)->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user").document(uid)
            .getDocument { documentSnapshot, error in
            
            guard let dictionary = documentSnapshot?.data() else { return }
            
            completion(User(dictionary: dictionary))
        }
    }
}
