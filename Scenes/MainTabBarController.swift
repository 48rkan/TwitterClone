//
//  MainTabBarController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 20.06.23.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    private lazy var actionButton: UIButton = {
        let b = UIButton()
        b.setImage(Assets.new_tweet.image(), for: .normal)
        b.backgroundColor = .twitterBlue
        b.tintColor = .white
        b.addTarget(self, action: #selector(tappedActionButton), for: .touchUpInside)
        return b
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthenticateUser()
        self.asads()
    }
    
    //MARK: - Actions
    @objc private func tappedActionButton() {
        print("tapped")
    }
}

//MARK: - Helpers
extension MainTabBarController {
    func checkAuthenticateUser() {
        
        DispatchQueue.main.async {
            if Auth.auth().currentUser == nil {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: false)
            } else {
                self.configureUI()
                self.configureTabBar()
            }
        }
    }
    
    private func asads() { try? Auth.auth().signOut() }
    
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingBottom: 64 ,paddingRight: 16)
        actionButton.setDimensions(height: 56, width: 56)
        actionButton.layer.cornerRadius = 28
    }
    
    private func configureTabBar() {
        let feed = templateNavigationController(controller: FeedController(),
                                                selectedImage: Assets.home_unselected.image(),
                                                unselectedImage: Assets.home_unselected.image())
        
        let explore = templateNavigationController(controller: ExploreController(),
                                                selectedImage: Assets.search_unselected.image(),
                                                unselectedImage: Assets.search_unselected.image())
        
        let notifications = templateNavigationController(controller: NotificationsControler(),
                                                selectedImage: Assets.like_unselected.image(),
                                                unselectedImage: Assets.like_unselected.image())
        
        let conversations = templateNavigationController(controller: ConversationsController(),
                                                selectedImage: Assets.mail.image(),
                                                unselectedImage: Assets.mail.image())
        
        viewControllers = [ feed , explore  , notifications  , conversations ]
    }
    
    func templateNavigationController(controller: UIViewController,
             selectedImage: UIImage,
             unselectedImage: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .white
        return nav

    }
}
