//  UserService.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import FirebaseAuth
import FirebaseFirestore
import UIKit

class AccountService {
    static let instance = AccountService()
    
    var currentUser: User?
    // bu yalniz movcud olan(1) useri bize verir.
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user")
            .document(uid)
            .getDocument { documentSnapshot, error in
            
            guard let dictionary = documentSnapshot?.data() else { return }
            self.currentUser = User(dictionary: dictionary)
        }
    }
}
