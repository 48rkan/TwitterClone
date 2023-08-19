//  FilterViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 30.06.23.

import Foundation

enum ProfileFilterOptions: Int,CaseIterable {
    case tweets
    case replies
    case likes

    var description: String {
        switch self {
        case .tweets  : return "Tweets"
        case .replies : return "Tweets & Replies"
        case .likes   : return "Likes"
        }
    }
}


