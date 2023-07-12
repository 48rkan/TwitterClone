//
//  SDWebImage+ext.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import Foundation
import SDWebImage

extension UIImageView {
    func setImage(stringURL: String) {
        self.sd_setImage(with: URL(string: stringURL))
    }
}
