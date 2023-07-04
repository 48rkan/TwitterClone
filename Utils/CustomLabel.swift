//
//  CustomLabel.swift
//  Giphy
//  Created by Erkan Emir on 14.05.23.

import UIKit

class CustomLabel: UILabel {
    
    init(text         : String,
         textColor    : UIColor? = .white,
         hexCode      : String?  = nil,
         size         : CGFloat? = nil,
         font         : String   = "Helvetica Neue",
         systemfont   : UIFont?  = nil,
         alignment    : NSTextAlignment = .center,
         numberOfLines: Int = 1)
     {
        super.init(frame: .zero)
        
        if let hexCode = hexCode {
            self.textColor = UIColor(hexString: hexCode)
        } else {
            self.textColor = textColor
        }
        
        if let systemfont = systemfont {
            self.font = systemfont
        } else {
            self.font = UIFont(name: font, size: size ?? CGFloat(1))

        }
        
        self.text = text
        
        textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}
