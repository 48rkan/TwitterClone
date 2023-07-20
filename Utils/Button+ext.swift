//
//  Button+ext.swift
//  TwitterClone
//  Created by Erkan Emir on 21.06.23.

import UIKit

extension UIButton {
    func createButton(image: String,
                      tintColor: UIColor,
                      height: CGFloat,width: CGFloat)  {
        self.setImage(UIImage(named: image), for: .normal)
        self.tintColor = tintColor
        self.setDimensions(height: height, width: width)
    }
}

extension UIButton  {
    func setButtonConfiguration(firstText: String,
                                firstTextColor: UIColor = .white,
                                secondText: String,
                                secondTextColor: UIColor = .white) {
        
        let firstTitle = NSMutableAttributedString(string: firstText,
                                                   attributes: [
                                                    .font: UIFont.systemFont(ofSize: 16),
                                                    .foregroundColor: firstTextColor
                                                   ])
        
        let secondTitle = NSMutableAttributedString(string: secondText,
                                                    attributes: [
                                                     .font: UIFont.boldSystemFont(ofSize: 16),
                                                     .foregroundColor: secondTextColor
                                                    ])
        firstTitle.append(secondTitle)
        self.setAttributedTitle(firstTitle, for: .normal)
    }
    
    func setDetailedButtonConfiguration(text1       : String,
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
        self.setAttributedTitle(firstTitle, for: .normal)
    }
}

