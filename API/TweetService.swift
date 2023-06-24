//
//  TweetService.swift
//  TwitterClone
//
//  Created by Erkan Emir on 24.06.23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct TweetService {
    
    static func uploadTweet(text:String,
                            user: User,
                            completion: @escaping (Error?)->()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        let data : [String:Any] = [
            "text"    : text,
            "likes"   : 0,
            "retweets": 0,
            "time"    : Timestamp(date: Date()),
            "ownerUid": uid,
            "ownerProfilImageUrl": user.profilimage,
            "ownerUserName"      : user.username,
            "ownerFullName"      : user.fullname,
            "liked"              : false
        ]
        
        Firestore.firestore().collection("tweets").document(uid).setData(data,completion: completion)
        
//        Firestore.firestore().collection("tweets").addDocument(data: data) { error in
//            completion(error)
//        }
        
    }
    
    //    static func fetchPosts(completion: @escaping ([Post])->()) {
    //        // descending - azalan sira
    //
    //        Firestore.firestore().collection("post")
    //            .order(by: "time", descending: true)
    //            .getDocuments { querySnapshot, error in
    //            guard let documents = querySnapshot?.documents else { return }
    //
    //            let posts = documents.map({ queryDocumentSnapshot in
    //                let dictionary = queryDocumentSnapshot.data()
    //
    //                return Post(postId: queryDocumentSnapshot.documentID , dictionary: dictionary)
    //            })
    //            completion(posts)
    //        }
    //    }
    
    
}
