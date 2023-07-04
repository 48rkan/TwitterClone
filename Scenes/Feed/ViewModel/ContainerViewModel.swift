//
//  ContainerViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 03.07.23.
//

import Foundation

enum MenuState {
    case opened,closed
}

class ContainerViewModel {
    let menuVC = MenuViewController()
    let feedVC = FeedController()
    
    var menuState: MenuState = .closed
}
