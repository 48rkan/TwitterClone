//  ContainerViewController.swift
//  TwitterClone
//  Created by Erkan Emir on 03.07.23.

import UIKit

class ContainerViewController: UIViewController {
    
    var viewModel = ContainerViewModel()
    var nav: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.feedVC.delegate = self
        addChildVCs()
    }
    
    func addChildVCs() {
        addChild(viewModel.menuVC)
        view.addSubview(viewModel.menuVC.view)
        viewModel.menuVC.didMove(toParent: self)
        
        let navVC = UINavigationController(rootViewController: viewModel.feedVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        self.nav = navVC
        navVC.didMove(toParent: self)
    }
}

extension ContainerViewController: FeedControllerDelegate {
    func didTapMenuButton() {
        switch viewModel.menuState {
        case .closed:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                
                self.nav?.view.frame.origin.x = self.viewModel.feedVC.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.viewModel.menuState = .opened
                }
            }
            
        case .opened:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                
                self.nav?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.viewModel.menuState = .closed
                }
            }
        }
    }
}
