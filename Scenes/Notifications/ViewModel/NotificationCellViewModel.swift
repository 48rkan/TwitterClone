//  NotificationCellViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import Foundation

class NotificationCellViewModel {
    var notification: Notification
    var callBack    : (()->())?
    
    init(notification: Notification) {
        self.notification = notification
        checkIfUserIsFollowed()
    }
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
            self.notification.userIsFollowed = isFollowed
            self.callBack?()
        }
    }
        
    var time : String { " \(notification.timestamp.convertToRealTime())"}
    var shouldShow: Bool { notification.type == .like || notification.type == .retweet}
    var shouldHide: Bool { notification.type == .follow }
    
    var buttonText: String {
        notification.userIsFollowed ? "Following" : "Follow"
    }
    
}
