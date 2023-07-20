//
//  FeedCellViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 26.06.23.

import Foundation
import FirebaseFirestore

protocol FeedCellProtocol {
    var fullName       : String    { get }
    var userName       : String    { get }
    var times          : Timestamp { get }
    var text           : String    { get }
    var ownerUID       : String    { get }
    var profileImageURL: String    { get }
    var tweetID        : String    { get }
}

class FeedCellViewModel {
    var items: FeedCellProtocol
    
    init(items: FeedCellProtocol) {
        self.items = items
    }
    
    var fullName: String { items.fullName  }
    var userName: String { " @\(items.userName)"  }
    var time    : String { " ∙ \(items.times.convertToRealTime())"}
}
