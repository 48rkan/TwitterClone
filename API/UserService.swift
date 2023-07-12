//  UserService.swift
//  TwitterClone
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
    
    static func fetchSelectedUser(userUid: String, completion: @escaping (User)->()) {
        
        Firestore.firestore().collection("user").document(userUid).getDocument { documentSnapshot, error in
            
            guard let dictionary = documentSnapshot?.data() else { return }
            
            completion(User(dictionary: dictionary))
        }
    }
    
    static func fetchAllUsers(completion: @escaping ([User])->()) {
        Firestore.firestore().collection("user").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            let users = documents.map({ return User(dictionary: $0.data()) })
            
            completion(users)
        }
    }
    
    static func follow(uid: String,completion: @escaping (Error?)->()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        // following - takip etme(follow etmek)
        
        Firestore.firestore()
            .collection("following")
            .document(currentUid)
            .collection("user-following").document(currentUid).setData([:])
        
        Firestore.firestore()
            .collection("following")
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .setData([:]) { error in
                
                // followers - takipci
                Firestore.firestore()
                    .collection("followers")
                    .document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .setData([:]) { error in
                        
                        completion(error)
                    }
            }
    }
    
    static func unfollow(uid: String,completion: @escaping (Error?)->()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore()
            .collection("following")
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .delete { error in
                
                Firestore.firestore()
                    .collection("followers")
                    .document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .delete { error in
                        completion(error)
                    }
            }
    }
    
    static func checkIfUserIsFollowed(uid: String,completion: @escaping (Bool)->()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore()
            .collection("following")
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .getDocument { documentSnapshot, error in
                // exist-var demekdir.Bir seyin varligini ifade edir.Varsa true dondurur , yoxdursa false.
                
                guard let isFollowed = documentSnapshot?.exists else { return }
                completion(isFollowed)
            }
    }
    
    static func fetchUserStatistic(uid: String,completion: @escaping (UserStatistic)->()) {
        
        Firestore.firestore()
            .collection("following")
            .document(uid)
            .collection("user-following")
            .getDocuments { querySnapshot, error in
                let following = querySnapshot?.count ?? 0
                
                Firestore.firestore()
                    .collection("followers")
                    .document(uid)
                    .collection("user-followers")
                    .getDocuments { querySnapshot, error in
                        let followers = querySnapshot?.count ?? 0
                        
                        completion(UserStatistic(followers: followers,
                                                 following: following))
                    
                    }
            }
    }
}
