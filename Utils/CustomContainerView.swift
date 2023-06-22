//
//  CustomContainerView.swift
//  TwitterClone
//
//  Created by Erkan Emir on 21.06.23.
//

import UIKit

protocol CustomContainerViewDelegate: AnyObject {
    func didChangeTextField(sender: UITextField, text: String)
}

class CustomContainerView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: CustomContainerViewDelegate?
    
    private lazy var imageView = UIImageView()
    let textField: UITextField =  {
        let tf = UITextField()
        tf.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
        return tf
    }()
    
    //MARK: - Lifecycle
    init(image: UIImage,placeholder: String,secure: Bool = false) {
        super.init(frame: .zero)
        configureUI(image: image, placeholder: placeholder,secure: secure)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    @objc func changedTextField(sender: UITextField) {
        delegate?.didChangeTextField(sender: sender, text: sender.text ?? "")
    }
    
    private func configureUI(image: UIImage,placeholder: String,secure: Bool) {
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
