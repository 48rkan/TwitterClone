//
//  FeedController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 20.06.23.
//

import UIKit

class FeedController: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension FeedController {
    func configureUI() {
        let imageView = Assets.twitterLogoBlue.imageView()
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
