//
//  FeedCellViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 26.06.23.

import Foundation

class FeedCellViewModel {
    var items: Tweet
    
    init(items: Tweet) {
        
        self.items = items
    }
    
    var fullName: String { items.ownerFullName  }
    var userName: String { " @\(items.ownerUserName)"  }
    var time    : String { " ∙ \(items.time.convertToRealTime())"}
}
