//
//  CustomContainerView.swift
//  TwitterClone
//
//  Created by Erkan Emir on 21.06.23.
//

import UIKit

class CustomContainerView: UIView {
    
    //MARK: - Properties
    private let imageView = UIImageView()
    let textField = UITextField()
    
    //MARK: - Lifecycle
    init(image: UIImage,placeholder: String,secure: Bool = false) {
        super.init(frame: .zero)
        configureUI(image: image, placeholder: placeholder,secure: secure)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI(image: UIImage,placeholder: String,secure: Bool) {
        addSubview(imageView)
        imageView.centerY(inView: self ,leftAnchor: leftAnchor,paddingLeft: 4)
        imageView.setDimensions(height: 24, width: 24)
        imageView.image = image
        
        addSubview(textField)
        textField.centerY(inView: self, leftAnchor: imageView.rightAnchor, paddingLeft: 4)
        textField.anchor(right: rightAnchor,paddingRight: 4)
        textField.textColor = .white
        textField.isSecureTextEntry = secure
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [.foregroundColor: UIColor.white])
        
        let divider = UIView()
        divider.backgroundColor = .white
        addSubview(divider)
        divider.anchor(top: textField.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 4,paddingLeft: 4,paddingBottom: 0)
        divider.setHeight(0.75)
        
    }
}
