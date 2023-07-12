//
//  TweetHeader.swift
//  TwitterClone
//  Created by Erkan Emir on 12.07.23.

import UIKit

class TweetHeader: UICollectionReusableView {
    
    //MARK: - Properties
    var viewModel: TweetHeaderViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds   = true
        
        return iv
    }()
    
    private let fullNameLabel: CustomLabel = {
        let l = CustomLabel(text      : "Eddie Brock",
                            textColor : .black,
                            size      : 16,
                            systemfont: UIFont.boldSystemFont(ofSize: 16),
                            alignment : .left)
        
        return l
    }()
    
    private let userNameLabel: CustomLabel = {
        let l = CustomLabel(text      : "@venom",
                            textColor : .lightGray,
                            size      : 14,
                            systemfont: UIFont.systemFont(ofSize: 14),
                            alignment : .left)
        return l
    }()
    
    private let captionLabel: UILabel = {
        let l           = UILabel()
        l.font          = UIFont.systemFont(ofSize: 20)
        l.numberOfLines = 0
        l.text          = "Hello,world"
        return l
    }()
    
    private let dateLabel: UILabel = {
        let l           = UILabel()
        l.font          = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .left
        l.textColor     = .lightGray
        
        return l
    }()
    
    private let optionsButton: UIButton = {
        let b = UIButton()
        b.setImage(Assets.downArrow.image(), for: .normal)
        b.tintColor = .lightGray
        return b
    }()
    
    private let retweetsLabel: UILabel = {
        let l  = UILabel()
        l.setDetailedLabelConfiguration(text1     : "0",
                                        text1Font : UIFont.boldSystemFont(ofSize: 14),
                                        text1Color: .black,
                                        text2     : " retweets",
                                        text2Font : UIFont.systemFont(ofSize: 14),
                                        text2Color: .lightGray)
        return l
    }()
    
    private let likesLabel: UILabel = {
        let l  = UILabel()
        l.setDetailedLabelConfiguration(text1     : "0",
                                        text1Font : UIFont.boldSystemFont(ofSize: 14),
                                        text1Color: .black,
                                        text2     : " likes",
                                        text2Font : UIFont.systemFont(ofSize: 14),
                                        text2Color: .lightGray)
        return l
    }()
        
    private lazy var commentButton: UIButton = {
        let b = UIButton()
        b.createButton(image    : Assets.comment.rawValue,
                       tintColor: .lightGray,
                       height   : 20,
                       width    : 20)
        return b
    }()
    
    private lazy var retweetButton: UIButton = {
        let b = UIButton()
        b.createButton(image    : Assets.retweet.rawValue,
                       tintColor: .lightGray,
                       height   : 20,
                       width    : 20)
        return b
    }()
    
    private lazy var likeButton: UIButton = {
        let b = UIButton()
        b.createButton(image    : Assets.like.rawValue,
                       tintColor: .lightGray,
                       height   : 20,
                       width    : 20)
        return b
    }()
    
    private lazy var shareButton: UIButton = {
        let b = UIButton()
        b.createButton(image    : Assets.share.rawValue,
                       tintColor: .lightGray,
                       height   : 20,
                       width    : 20)
        return b
    }()
       
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Actions
    func configure() {
        guard let viewModel else { return }
        fullNameLabel.text = viewModel.fullNameLabel
        userNameLabel.text = viewModel.userNameLabel
        dateLabel.text     = viewModel.time
        captionLabel.text  = viewModel.caption
        profileImageView.setImage(stringURL: viewModel.profileImage)
    }
}

//MARK: - Helpers
extension TweetHeader {
    func configureUI() {
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,
                                left: leftAnchor,
                                paddingTop: 8,paddingLeft: 8)
        profileImageView.setDimensions(height: 60, width: 60)
        profileImageView.layer.cornerRadius = 30
        
        let stack = UIStackView(arrangedSubviews: [fullNameLabel,userNameLabel])
        stack.axis = .vertical
        addSubview(stack)
        stack.anchor(top: topAnchor,left: profileImageView.rightAnchor,
                     paddingTop: 16,paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: profileImageView.bottomAnchor,
                            left: leftAnchor,right: rightAnchor,
                            paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.bottomAnchor,
                         left: leftAnchor,
                         paddingTop: 20,paddingLeft: 16)
        
        addSubview(optionsButton)
        optionsButton.centerY(inView: stack)
        optionsButton.anchor(right: rightAnchor,paddingRight: 8)
        optionsButton.setDimensions(height: 24, width: 24)
        
        let dividerView = UIView()
        addSubview(dividerView)
        dividerView.backgroundColor = .lightGray
        dividerView.anchor(top: dateLabel.bottomAnchor,
                           left: leftAnchor,right: rightAnchor,
                           paddingTop: 8,paddingLeft: 4,paddingRight: 4)
        dividerView.setHeight(0.5)
        
        let labelStack = UIStackView(arrangedSubviews: [retweetsLabel,likesLabel])
        addSubview(labelStack)
        labelStack.anchor(top: dividerView.bottomAnchor,
                          left: leftAnchor,
                          paddingTop: 8,paddingLeft: 8)
        labelStack.axis         = .horizontal
        labelStack.spacing      = 8
        labelStack.distribution = .fillEqually
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton,retweetButton,likeButton,shareButton])
        addSubview(actionStack)
        actionStack.spacing      = 4
        actionStack.axis         = .horizontal
        actionStack.distribution = .fillEqually
        actionStack.anchor(left: leftAnchor,bottom: bottomAnchor,
                           right: rightAnchor,paddingLeft: 4,
                           paddingBottom: 12,paddingRight: 12)
    }
}
