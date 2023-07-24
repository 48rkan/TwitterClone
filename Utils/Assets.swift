//  Assets.swift
//  TwitterClone
//  Created by Erkan Emir on 20.06.23.

import UIKit

enum Assets: String {
    case home_unselected
    case search_unselected
    case like_unselected
    case comment        
    case retweet
    case like
    case share
    case like_filled
    case mail            = "ic_mail_outline_white_2x-1"
    case twitterLogoBlue = "twitter_logo_blue"
    case new_tweet       = "new_tweet"
    case twitterLogo     = "TwitterLogo"
    case lock            = "ic_lock_outline_white_2x"
    case plus            = "plus_photo"
    case person          = "ic_person_outline_white_2x"
    case back            = "baseline_arrow_back_white_24dp"
    case downArrow       = "down_arrow_24pt"
    
    func image() -> UIImage {
        UIImage(named: self.rawValue)!
    }
    
    func imageView() -> UIImageView {
        UIImageView(image: self.image())
    }
     
}
