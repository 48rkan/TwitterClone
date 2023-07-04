//
//  ConversationsController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 20.06.23.
//


import UIKit

class ConversationsController: UIViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension ConversationsController {
    func configureUI() {
        navigationItem.title = "Messages"
    }
}
