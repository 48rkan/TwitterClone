//
//  FeedController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 20.06.23.

import UIKit

class FeedController: UIViewController {
    
    var viewModel = FeedViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - Helpers
extension FeedController {
    private func configureUI() {
        view.backgroundColor = .white
        
        configNavigationBarItems()
        
    }
    
    private func configNavigationBarItems() {
        let iv = Assets.twitterLogoBlue.imageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 44, width: 44)
        navigationItem.titleView = iv
        
        let v = UIImageView()
        v.setDimensions(height: 36, width: 36)
        v.layer.cornerRadius = 18
        v.clipsToBounds = true
        
        viewModel.callBack = {
            v.setImage(stringURL: self.viewModel.profilimage ?? "")
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: v)
    }
}
