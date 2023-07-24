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
            "ownerUserName"           : user.username,
            "ownerProfilImageUrl"     : user.profilimage,
            "ownerFullName"           : user.fullname
        ]
        
        Firestore.firestore().collection("tweets")
            .document(tweetID)
            .collection("comments")
            .addDocument(data: data) { error in
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
}
