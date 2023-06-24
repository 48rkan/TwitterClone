//
//  CustomTextView.swift
//  TwitterClone
//
//  Created by Erkan Emir on 24.06.23.

import UIKit

protocol CustomTextViewDelegate: AnyObject {
    func doEnabled()
}

class CustomTextView: UITextView {
    
    weak var delegate_: CustomTextViewDelegate?
    
    private let placeholder: UILabel = {
        let l       = UILabel()
        l.font      = UIFont.systemFont(ofSize: 16)
        l.textColor = .darkGray
        
        return l
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    convenience init(text: String) {
        self.init()
        configureUI(text: text)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI(text: String) {
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        
        addSubview(placeholder)
        placeholder.anchor(top: topAnchor,left: leftAnchor,
                           paddingTop: 8,paddingLeft: 4)
        placeholder.text = text
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextView), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func handleTextView() {
        placeholder.isHidden =  !self.text.isEmpty
        delegate_?.doEnabled()
        
    }
}
