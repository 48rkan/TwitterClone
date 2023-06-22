//
//  Button+ext.swift
//  TwitterClone
//
//  Created by Erkan Emir on 21.06.23.
//

import UIKit

extension UIButton {
    func setButtonConfiguration(firstText: String, secondText: String) {
        let firstTitle = NSMutableAttributedString(string: firstText,
                                                   attributes: [
                                                    .font: UIFont.systemFont(ofSize: 16),
                                                    .foregroundColor: UIColor.white
                                                   ])
        
        let secondTitle = NSMutableAttributedString(string: secondText,
                                                    attributes: [
                                                     .font: UIFont.boldSystemFont(ofSize: 16),
                                                     .foregroundColor: UIColor.white
                                                    ])
        firstTitle.append(secondTitle)
        self.setAttributedTitle(firstTitle, for: .normal)
    }
}
