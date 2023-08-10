//  NotificationService.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

struct NotificationService {
    // 1. burda  fikir budur ki , biz notification'lari spesifik bir user'e gondermeliyik.Yeni user erkan99 profilindedirse bildirimler ona getmelidir.Ve yaxud basqasina elediyin bir actionun bildirimi de , ona getmelidir.
    static func uploadNotification(notificationOwnerUid: String,
                                   fromUser: User,
                                   notificationtype: NotificationType,
                                   tweet: Tweet? = nil) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if notificationOwnerUid == currentUid { return }
        
        let dataRef = Firestore.firestore().collection("notifications").document(notificationOwnerUid).collection("user-notifications").document()
        
        var data: [String:Any] = [
            "timestamp"         : Timestamp(date: Date()),
            "type"              : notificationtype.rawValue,
            "username"          : fromUser.username,
            "userProfilImageUrl": fromUser.profilimage,
            "uid"               : fromUser.uid,
            "documentID"        : dataRef.documentID
        ]
        
        if let tweet = tweet {
            data["postID"]       = tweet.tweetID
            data["postImageUrl"] = tweet.ownerProfilImageUrl
        }
        
        dataRef.setData(data)
    }
    
    static func fetchNotifications(completion: @escaping ([Notification])->()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("notifications").document(currentUid).collection("user-notifications").getDocuments { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else { return }

            let notifications = documents.map({ Notification(dictionary: $0.data()) })
            completion(notifications)
        }
    }
}
