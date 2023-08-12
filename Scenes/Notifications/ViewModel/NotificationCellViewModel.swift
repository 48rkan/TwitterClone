//  NotificationCellViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import Foundation

class NotificationCellViewModel {
    
    //MARK: - Properties
    var notification: Notification
    
    //MARK: - Lifecylce
    init(notification: Notification) {
        self.notification = notification
    }
    
    var time      : String { " \(notification.timestamp.convertToRealTime())"}
    var shouldShow: Bool   { notification.type == .like || notification.type == .retweet }
    var shouldHide: Bool   { notification.type == .follow }
    
    var buttonText: String {
        notification.userIsFollowed ? "Following" : "Follow"
    }
    
}
