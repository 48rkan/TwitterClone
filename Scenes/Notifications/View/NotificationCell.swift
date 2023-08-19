//  NotificationCell.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import UIKit

protocol NotificationCellDelegate: AnyObject {
    func didTapProfile(_ cell: NotificationCell)

    func cell(_ cell:NotificationCell, wantsToFollow      uid: String)
    func cell(_ cell:NotificationCell, wantsToUnFollow    uid: String)
}

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    weak var delegate: NotificationCellDelegate?
    
    var viewModel: NotificationCellViewModel? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedProfileImageView)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let infoLabel = UILabel()
    
    lazy var followOrUnfollowButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(.twitterBlue, for: .normal)
        b.backgroundColor   = .white
        b.layer.borderColor = UIColor.twitterBlue.cgColor
        b.layer.borderWidth = 2
        b.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
        b.addTarget(self, action: #selector(tappedFollowButton), for: .touchUpInside)
        return b
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()        
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }

    //MARK: - Actions
    @objc func tappedProfileImageView() {
        delegate?.didTapProfile(self)
    }
     
    @objc func tappedFollowButton() {
        guard let viewModel = viewModel else { return }

        if viewModel.notification.userIsFollowed {
            delegate?.cell(self, wantsToUnFollow: viewModel.notification.uid)
        } else {
            delegate?.cell(self, wantsToFollow: viewModel.notification.uid)
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        selectionStyle = .none
        
        contentView.addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: contentView.leftAnchor,paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.clipsToBounds      = true
        profileImageView.layer.cornerRadius = 20
        
        contentView.addSubview(followOrUnfollowButton)
        followOrUnfollowButton.anchor(top: contentView.topAnchor,
                                      bottom: contentView.bottomAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 12,paddingBottom: 12,paddingRight: 4)
        followOrUnfollowButton.setDimensions(height: 32, width: 80)
        followOrUnfollowButton.isHidden = true
        followOrUnfollowButton.layer.cornerRadius = 16

        contentView.addSubview(infoLabel)
        infoLabel.centerY(inView: self,leftAnchor: profileImageView.rightAnchor,paddingLeft: 8)
        infoLabel.anchor(right: followOrUnfollowButton.leftAnchor,paddingRight: 4)
    }
    
    func configure() {
        guard let notifications = viewModel?.notification else { return }
        guard let viewModel else { return }
        profileImageView.setImage(stringURL: notifications.userProfilImageUrl)
        
        infoLabel.setDetailedLabelConfiguration(text1: notifications.username,
                                                text1Font: UIFont.boldSystemFont(ofSize: 14),
                                                text1Color: .black,
                                                text2: notifications.type.notificationMessage,
                                                text2Font: UIFont.systemFont(ofSize: 14),
                                                text2Color: .black,
                                                text3: "\(viewModel.time)",
                                                text3Font: UIFont.systemFont(ofSize: 12),
                                                text3Color: .lightGray)
        
        followOrUnfollowButton.setTitle(viewModel.buttonText, for: .normal)

        guard viewModel.shouldHide else { return }
        followOrUnfollowButton.isHidden = false
    }
}
