//  NotificationViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import Foundation

class NotificationViewModel {
    
    //MARK: - Properties
    var notifications = [Notification]()
    var successCallBack: (()->())?
    
    //MARK: - Lifecylce
    init() {
        fetchNotifications {
            self.checkIfUserIsFollowed()
        }
    }
    
    //MARK: - Methods
    func fetchNotifications(completion: @escaping ()->()) {
        NotificationService.fetchNotifications { notifications in
            self.notifications = notifications
            completion()
        }
    }
    
    func checkIfUserIsFollowed()  {
        notifications.forEach { notification in
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                guard let index = self.notifications.firstIndex(where: { $0.documentID  == notification.documentID }) else { return }
                self.notifications[index].userIsFollowed = isFollowed
                self.successCallBack?()
            }
        }
    }
    
    func fetchSelectedUser(userUid: String,completion: @escaping (User)->()) {
        UserService.fetchSelectedUser(userUid: userUid) { user in
            completion(user)
        }
    }
}
