//  TweetService.swift
//  TwitterClone
//  Created by Erkan Emir on 24.06.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct TweetService {
    
    static func uploadTweet(text      :String,
                            user      : User,
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
    
    static func deleteTweet(tweetID: String) {
        Firestore.firestore().collection("tweets").document(tweetID).delete()
    }
    
    
    static func likeTweet(tweet: Tweet , completion: @escaping (Error?)->()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
// Firestore.firestore().collection("post").document(tweet.tweetID).updateData(["likes": tweet.likes + 1 ])
//        Firestore.firestore().collection("post").document(tweet.tweetID).updateData(["liked": true ])
//
        Firestore.firestore().collection("tweets").document(tweet.tweetID).collection("post-likes").document(uid).setData([:]) { _ in
            
            Firestore.firestore().collection("user").document(uid).collection("user-likes").document(tweet.tweetID).setData([:]) { error in
                completion(error)
            }
        }
    }
    
    static func unLikeTweet(tweet: Tweet , completion: @escaping (Error?)->()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
//        //condition qoyulmalidi 0 dan boyuk olsun
//        Firestore.firestore().collection("post").document(post.postId).updateData(["likes": post.likes - 1 ])
//
//        Firestore.firestore().collection("post").document(post.postId).updateData(["liked": false ])
        
        Firestore.firestore().collection("tweets").document(tweet.tweetID).collection("post-likes").document(uid).delete { _ in
            
            Firestore.firestore().collection("user").document(uid).collection("user-likes").document(tweet.tweetID).delete { error in
                completion(error)
            }
        }
    }
    
    static func checkTweetIfLiked(tweet: Tweet , completion : @escaping (Bool)->()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user").document(uid).collection("user-likes").document(tweet.tweetID).getDocument { documentSnapshot, error in
            guard let isLiked = documentSnapshot?.exists else { return }
            
            completion(isLiked)
        }
    }
}
