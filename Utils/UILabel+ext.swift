//
//  UILabel+ext.swift
//  TwitterClone
//  Created by Erkan Emir on 01.07.23.

import UIKit

extension UILabel {
    func setDetailedLabelConfiguration  (text1       : String,
                                        text1Font   : UIFont,
                                        text1Color  : UIColor,
                                        text2       : String,
                                        text2Font   : UIFont,
                                        text2Color  : UIColor,
                                        text3       : String  = "",
                                        text3Font   : UIFont  = UIFont.systemFont(ofSize: 14),
                                        text3Color  : UIColor = .white) {
        
        let firstTitle = NSMutableAttributedString(string: text1,
                                                   attributes: [
                                                    .font: text1Font,
                                                    .foregroundColor: text1Color,
                                                   ])
        
        let secondTitle = NSMutableAttributedString(string: text2,
                                                    attributes: [
                                                     .font: text2Font,
                                                     .foregroundColor: text2Color
                                                    ])
        let thirdTitle = NSMutableAttributedString(string: text3,
                                                   attributes: [
                                                    .font: text3Font,
                                                    .foregroundColor: text3Color
                                                   ])
        
        firstTitle.append(secondTitle)
        firstTitle.append(thirdTitle)
        self.attributedText = firstTitle
    }
}
