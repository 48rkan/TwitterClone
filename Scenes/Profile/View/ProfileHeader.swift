//  ProfileHeader.swift
//  TwitterClone
//  Created by Erkan Emir on 29.06.23.

import UIKit

protocol ProfileHeaderDelegate: AnyObject {
    func header(_ wantsToDismissal: UICollectionReusableView)
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    var viewModel: ProfileHeaderViewModel? {
        didSet {
            configure()
        }
    }
    
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let bannerView: UIView = {
        let v = UIView()
        v.backgroundColor = .twitterBlue
        return v
    }()
    
    private lazy var backButton: UIButton = {
        let b  = UIButton(type: .system)
        b.tintColor = .white
        b.setImage(Assets.back.image(), for: .normal)
        b.addTarget(self,
                    action: #selector(tappedBackButton),
                    for: .touchUpInside)
        return b
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode     = .scaleAspectFill
        iv.clipsToBounds   = true
        return iv
    }()
 
    private let editProfileOrFollowButton: CustomButton = {
        let b = CustomButton(title     : "Loading",
                             titleColor: .twitterBlue,
                             systemFont: UIFont.boldSystemFont(ofSize: 14),
                             size      : 14)
        return b
    }()
    
    private let fullNameLabel: CustomLabel = {
        let l = CustomLabel(text      : "Eddie Brock",
                            textColor : .black,
                            systemfont: UIFont.boldSystemFont(ofSize: 20))
        return l
    }()
    
    private let userNameLabel: CustomLabel = {
        let l = CustomLabel(text      : "@venom",
                            textColor : .lightGray,
                            systemfont: UIFont.systemFont(ofSize: 16))
        return l
    }()
    
    private let descriptionLabel: CustomLabel = {
        let l = CustomLabel(text         : "Test biography",
                            textColor    : .black,
                            systemfont   : UIFont.systemFont(ofSize: 16),
                            alignment    : .left,
                            numberOfLines: 3)
        return l
    }()
    
    private let followingLabel: UILabel = {
        let l  = UILabel()
        l.setDetailedLabelConfiguration(text1     : "2",
                                        text1Font : UIFont.boldSystemFont(ofSize: 14),
                                        text1Color: .black,
                                        text2     : " followers",
                                        text2Font : UIFont.systemFont(ofSize: 14),
                                        text2Color: .lightGray)
        return l
    }()
    
    private let followersLabel: UILabel = {
        let l  = UILabel()
        l.setDetailedLabelConfiguration(text1     : "0",
                                        text1Font : UIFont.boldSystemFont(ofSize: 14),
                                        text1Color: .black,
                                        text2     : " following",
                                        text2Font : UIFont.systemFont(ofSize: 14),
                                        text2Color: .lightGray)
        return l
    }()
    
    private lazy var filterView: FilterView = {
        let f = FilterView()
        f.delegate = self
        return f
    }()
    
    private let underLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .twitterBlue
        return v
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Actions
    @objc func tappedBackButton() {
        delegate?.header(self)
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        fullNameLabel.text = viewModel.fullName
        userNameLabel.text = viewModel.userName
        editProfileOrFollowButton.setTitle(viewModel.buttonTitle, for: .normal)
        profileImageView.setImage(stringURL: viewModel.profileImageURL)
    }
}

//MARK: - Helper methods
extension ProfileHeader {
    func configureUI() {
        addSubview(bannerView)
        bannerView.anchor(top: topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 0,paddingLeft: 0,paddingRight: 0)
        bannerView.equalHeight(percent: 0.33, mainHeight: heightAnchor)
        
        bannerView.addSubview(backButton)
        backButton.anchor(top: bannerView.topAnchor,
                          left: bannerView.leftAnchor,
                          paddingTop: 42,paddingLeft: 16)
        backButton.setDimensions(height: 30, width: 30)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: bannerView.bottomAnchor,
                                left: leftAnchor,
                                paddingTop: -24 ,paddingLeft: 8)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.borderColor  = UIColor.white.cgColor
        profileImageView.layer.borderWidth  = 4
        
        addSubview(editProfileOrFollowButton)
        editProfileOrFollowButton.anchor(top: bannerView.bottomAnchor,
                                 right: rightAnchor,
                                 paddingTop: 12,paddingRight: 12)
        editProfileOrFollowButton.setDimensions(height: 36, width: 100)
                
        editProfileOrFollowButton.layer.cornerRadius = 18
        editProfileOrFollowButton.clipsToBounds      = true
        editProfileOrFollowButton.layer.borderColor  = UIColor.twitterBlue.cgColor
        editProfileOrFollowButton.layer.borderWidth  = 1.25
        
        addSubview(fullNameLabel)
        fullNameLabel.anchor(top: profileImageView.bottomAnchor,
                             left: leftAnchor,
                             paddingTop: 0,paddingLeft: 6)
        
        addSubview(userNameLabel)
        userNameLabel.anchor(top: fullNameLabel.bottomAnchor,
                             left: leftAnchor,
                             paddingTop: 0,paddingLeft: 8)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: userNameLabel.bottomAnchor,
                                left: leftAnchor,
                                right: rightAnchor,
                                paddingTop: 8,paddingLeft: 8,paddingRight: 4)
        
        let stack = UIStackView(arrangedSubviews: [followingLabel,
                                                   followersLabel])
        stack.axis         = .horizontal
        stack.spacing      = 8
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.anchor(top: descriptionLabel.bottomAnchor,
                     left: leftAnchor,
                     paddingTop: 8,paddingLeft: 8)
        
        addSubview(filterView)
        filterView.anchor(top: stack.bottomAnchor,left: leftAnchor,
                          bottom: bottomAnchor,right: rightAnchor,
                          paddingTop: 4,paddingLeft: 0,
                          paddingBottom: 0,paddingRight: 0)
        filterView.setHeight(50)
        
        addSubview(underLineView)
        underLineView.anchor(left: leftAnchor,bottom: bottomAnchor)
        
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        underLineView.setDimensions(height: 2, width: frame.width / count)
    }
}

//MARK: - FilterViewDelegate
extension ProfileHeader: FilterViewDelegate {
    func view(_ view: FilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collection.cellForItem(at: indexPath) as? FilterCell else { return }

        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underLineView.frame.origin.x = xPosition
        }
    }
}
