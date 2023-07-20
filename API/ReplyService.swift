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
            "comment"            : comments,
            "timestamp"          : Timestamp(date: Date()),
            "userUid"            : user.uid,
            "username"           : user.username,
            "userProfileImageUrl": user.profilimage,
            "fullName"           : user.fullname
        ]
        
        Firestore.firestore().collection("tweets")
            .document(tweetID)
            .collection("comments")
            .addDocument(data: data) { error in
                completion(error)
            }
    }
    
    static func fetchReplies(tweetID: String,completion: @escaping (([Reply])->())) {
        Firestore.firestore()
            .collection("tweets")
            .document(tweetID).collection("comments")
            .order(by: "timestamp", descending: false)
            .getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                
                let comments = documents.map { queryDocumentSnapshot in
                    let dictionary = queryDocumentSnapshot.data()
                    return Reply(dictionary: dictionary)
                }
                completion(comments)
            }
    }
}
