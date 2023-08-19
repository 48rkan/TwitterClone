//
//  ReplyService.swift
//  TwitterClone
//  Created by Erkan Emir on 15.07.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ReplyService {
    static func uploadReply(comments  : String,
                            tweetID   : String,
                            user      : User,
                            completion: @escaping (Error?)->()) {
        
        let data: [String:Any] = [
            "text"               : comments,
            "time"               : Timestamp(date: Date()),
            "ownerUID"           : user.uid,
            "ownerUserName"      : user.username,
            "ownerProfilImageUrl": user.profilimage,
            "ownerFullName"      : user.fullname
        ]
        
        Firestore.firestore().collection("tweets")
            .document(tweetID)
            .collection("comments")
            .addDocument(data: data) { error in
                
                guard let uid = Auth.auth().currentUser?.uid else { return }

                Firestore.firestore().collection("user").document(uid).collection("user-replies").document(tweetID).setData([:]) { error in
                    completion(error)
                }
                completion(error)
            }
    }
    
    static func fetchReplies(tweetID: String,
                             completion: @escaping (([Tweet])->())) {
        Firestore.firestore()
            .collection("tweets")
            .document(tweetID).collection("comments")
            .order(by: "time", descending: false)
            .getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                
                let comments = documents.map { queryDocumentSnapshot in
                    let dictionary = queryDocumentSnapshot.data()
                    return Tweet(tweetID: tweetID, dictionary: dictionary)
                }
                completion(comments)
            }
    }
    
    static func fetchSelectedReplies(user: User , completion: @escaping ([Tweet])->()) {
        var tweets = [Tweet]()

        Firestore.firestore().collection("user").document(user.uid).collection("user-replies").getDocuments { query, _ in
            query?.documents.forEach({ document in
                
                Firestore.firestore()
                    .collection("tweets")
                    .document(document.documentID)
                    .getDocument { snapshot, error in
                        guard let snapshot   = snapshot else { return }
                        guard let dictionary = snapshot.data() else { return }
                        
                        var tweet = Tweet(tweetID: snapshot.documentID,
                                          dictionary: dictionary)
                        tweet.liked = true
                        
                        tweets.append(tweet)
                    }
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(tweets)
        }
    }
}
