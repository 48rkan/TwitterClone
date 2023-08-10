//  NotificationCell.swift
//  TwitterClone
//  Created by Erkan Emir on 08.08.23.

import UIKit

protocol NotificationCellDelegate: AnyObject {
    func didTapProfile(_ cell: NotificationCell)
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
    
    private let follorOrUnfollowButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .blue
//        b.setTitle("Follow", for: .normal)
//
        return b
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
        viewModel?.callBack = { self.configure() }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helpers
    func configureUI() {
        selectionStyle = .none
        
        contentView.addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: contentView.leftAnchor,paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.clipsToBounds      = true
        profileImageView.layer.cornerRadius = 20
        
        contentView.addSubview(follorOrUnfollowButton)
        follorOrUnfollowButton.anchor(top: contentView.topAnchor,
                                      bottom: contentView.bottomAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 12,paddingBottom: 12,paddingRight: 4)
        follorOrUnfollowButton.setDimensions(height: 20, width: 60)
        follorOrUnfollowButton.isHidden = true


        contentView.addSubview(infoLabel)
        infoLabel.centerY(inView: self,leftAnchor: profileImageView.rightAnchor,paddingLeft: 8)
        infoLabel.anchor(right: follorOrUnfollowButton.leftAnchor,paddingRight: 4)
    }
    
    //MARK: - Actions
    @objc func tappedProfileImageView() {
        delegate?.didTapProfile(self)
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
        if viewModel.notification.userIsFollowed  {
            follorOrUnfollowButton.setTitle("aa", for: .normal)
        } else {
            follorOrUnfollowButton.setTitle("bb", for: .normal)
        }

//        follorOrUnfollowButton.setTitle(viewModel.buttonText, for: .normal)
        
        guard viewModel.shouldHide else { return }
        follorOrUnfollowButton.isHidden = false
    }
}
