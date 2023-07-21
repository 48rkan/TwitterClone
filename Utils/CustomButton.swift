//  CustomButton.swift
//  Giphy
//  Created by Erkan Emir on 07.06.23.

import UIKit

class CustomButton: UIButton {
    
    //MARK: - Lifecycle
    init(backgroundColor: UIColor? = nil,
         hexCode     : String?  = nil,
         title       : String,
         titleColor  : UIColor,
         font        : String? = nil,
         systemFont  : UIFont?  = nil,
         size        : CGFloat,
         cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds      = true
        
        if let font = font {
            self.titleLabel?.font = UIFont(name: font, size: size)
        } else {
            self.titleLabel?.font = systemFont
        }
        
        if let hexCode = hexCode {
            self.backgroundColor = UIColor(hexString: hexCode)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}
