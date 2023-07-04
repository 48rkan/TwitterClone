//  TweetService.swift
//  TwitterClone
//  Created by Erkan Emir on 24.06.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct TweetService {
    
    static func uploadTweet(text:String,
                            user: User,
                            completion: @escaping (Error?)->()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data: [String:Any] = [
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
        
        Firestore.firestore().collection("tweets").addDocument(data: data)
    }
    
    static func fetchTweets(completion: @escaping ([Tweet])->()) {
        
        Firestore.firestore().collection("tweets")
            .order(by: "time", descending: true)
            .getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }

            let tweets = documents.map({ queryDocumentSnapshot in
                let dictionary = queryDocumentSnapshot.data()
                let id         = queryDocumentSnapshot.documentID
                
                return Tweet(tweetID: id, dictionary: dictionary)
            })
            completion(tweets)
        }
    }
    
    static func fetchSelectedUserTweets(userUid:String,completion: @escaping ( [Tweet])->()) {
        Firestore.firestore()
            .collection("tweets")
            .whereField("ownerUid", isEqualTo: userUid)
            .getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                
                var posts = documents.map { Tweet(tweetID: $0.documentID , dictionary: $0.data()) }
                
                posts.sort { $0.time.seconds > $1.time.seconds }
                
                completion(posts)
            }
    }
}
