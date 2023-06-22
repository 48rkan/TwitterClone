//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 20.06.23.
//

import UIKit

class ExploreController: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
     
    }
}

extension ExploreController {
    func configureUI() {
        navigationItem.title = "Explore"
    }
}
