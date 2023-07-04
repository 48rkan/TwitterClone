//  MenuFilterOptions.swift
//  TwitterClone
//  Created by Erkan Emir on 03.07.23.

import Foundation

enum MenuFilterOptions: Int,CaseIterable {
    case profile
    case lists
    case topics
    case bookmarks
    case moments
    case monetization
    
    var description: String {
        switch self {
        case .profile     : return "Profile"
        case .lists       : return "Lists"
        case .topics      : return "Topics"
        case .bookmarks   : return "Bookmarks"
        case .moments     : return "Moments"
        case .monetization: return "Monetization"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile     : return "person.fill"
        case .lists       : return "list.clipboard.fill"
        case .topics      : return "rectangle.inset.toptrailing.filled"
        case .bookmarks   : return "bookmark"
        case .moments     : return "thermometer.sun"
        case .monetization: return "moonphase.first.quarter"
        }
    }
}
