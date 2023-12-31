//
//  UploadViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import Foundation

enum UploadViewConfiguration {
    case tweet
    case replies(Tweet)
}

class UploadViewModel {
    //MARK: - Properties
    var buttonTitle         : String?
    var placeHolderText     : String?
    var shouldShowReplyLabel: Bool?
    var replyText           : String?
    var configuration       : UploadViewConfiguration

    //MARK: - Lifecycle
    init(configuration: UploadViewConfiguration) {
        self.configuration = configuration
        
        switch configuration {
        case .tweet:
            self.buttonTitle          = "Tweet"
            self.placeHolderText      = "Enter caption"
            self.shouldShowReplyLabel = false
            
        case .replies(let tweet):
            self.buttonTitle          = "Reply"
            self.placeHolderText      = "Enter reply"
            self.shouldShowReplyLabel = true
            self.replyText            = "Replying to @\(tweet.ownerUserName)"
        }
    }
}

extension UploadViewModel {
    var user: User {
        AccountService.instance.currentUser ?? User(dictionary: ["" : ""])
    }
    
    var profilimage: String {
        AccountService.instance.currentUser?.profilimage ?? ""
    }
}
