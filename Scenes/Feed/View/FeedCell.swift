//  FeedCell.swift
//  TwitterClone
//  Created by Erkan Emir on 26.06.23.

protocol FeedCellDelegate: AnyObject {
    func cell(_ wantsToShowProfileScene: FeedCell ,ownerUid: String)
    func cell(_ wantsToReplies: FeedCell ,uid: String)

}

import UIKit

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    weak var delegate: FeedCellDelegate?
    
    var viewModel: FeedCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedProfileImageView)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let infoButton: UIButton = {
        let b = UIButton()
        b.setButtonConfiguration(firstText: "Eddie Brock",firstTextColor: .black, secondText: " venom",secondTextColor: .lightGray)
        
        return b
    }()
    
    private lazy var commentButton: UIButton = {
        let b = UIButton()
        b.setImage(Assets.comment.image(), for: .normal)
        b.tintColor = .lightGray
        b.addTarget(self, action: #selector(tappedCommentButton), for: .touchUpInside)
        return b
    }()
    
    
    
    private lazy var retweetButton: UIButton = {
        let b = UIButton()
        b.setImage(Assets.retweet.image(), for: .normal)
        b.tintColor = .lightGray
        return b
    }()
    
    private lazy var likeButton: UIButton = {
        let b = UIButton()
        b.setImage(Assets.like.image(), for: .normal)
        b.tintColor = .lightGray
        return b
    }()
    
    private lazy var shareButton: UIButton = {
        let b = UIButton()
        b.setImage(Assets.share.image(), for: .normal)
        b.tintColor = .lightGray
        return b
    }()
    
    private let captionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Actions
    @objc func tappedProfileImageView() {
        delegate?.cell(self, ownerUid: viewModel?.items.ownerUID ?? "")
    }
    
    @objc func tappedCommentButton() {
        delegate?.cell(self, uid: viewModel?.items.ownerUID ?? "")
    }
}

//MARK: - Helper
extension FeedCell {
    private func configureUI() {
        self.backgroundColor = .white
        
        contentView.addSubview(profileImageView)
        profileImageView.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                paddingTop: 4,paddingLeft: 8)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 24
        
        contentView.addSubview(infoButton)
        infoButton.anchor(top: contentView.topAnchor,
                          left: profileImageView.rightAnchor,
                          paddingTop: 2,paddingLeft: 4)
        
        let stack = UIStackView(arrangedSubviews: [
            commentButton,retweetButton,
            likeButton,shareButton
        ])
        
        contentView.addSubview(stack)
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        stack.anchor(left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingLeft: 4,paddingBottom: 4,
                     paddingRight: 4)
        stack.setHeight(20)
        
        contentView.addSubview(captionLabel)
        captionLabel.anchor(top: infoButton.bottomAnchor,
                            left: profileImageView.rightAnchor,
                            right: rightAnchor,paddingTop: 2,
                            paddingLeft: 8,paddingRight: 8)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        captionLabel.text = viewModel.items.text

        profileImageView.setImage(stringURL: viewModel.items.ownerProfilImageUrl)
        
        infoButton.setDetailedButtonConfiguration(text1     : viewModel.fullName,
                                                  text1Font : UIFont.boldSystemFont(ofSize: 14),
                                                  text1Color: .black,
                                                  text2     : viewModel.userName,
                                                  text2Font : UIFont.systemFont(ofSize: 14),
                                                  text2Color: .lightGray,
                                                  text3     : viewModel.time,
                                                  text3Font : UIFont.systemFont(ofSize: 14),
                                                  text3Color: .lightGray)

    }
}
