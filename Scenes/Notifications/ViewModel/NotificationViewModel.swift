//  NotificationViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import Foundation

class NotificationViewModel {
    
    //MARK: - Properties
    var notifications = [Notification]()
    
    //MARK: - Lifecylce
    init() {
        fetchNotifications()
    }
    
    //MARK: - Methods
    func fetchNotifications() {
        NotificationService.fetchNotifications { notifications in
            self.notifications = notifications
        }
    }
}
