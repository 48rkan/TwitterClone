//
//  NotificationsControler.swift
//  TwitterClone
//
//  Created by Erkan Emir on 20.06.23.
//

import UIKit

class NotificationsControler: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension NotificationsControler {
    func configureUI() {
        navigationItem.title = "Notifications"
    }
}
