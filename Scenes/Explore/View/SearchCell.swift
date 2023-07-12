//  SearchCell.swift
//  TwitterClone
//  Created by Erkan Emir on 05.07.23.

import UIKit

class SearchCell: UITableViewCell {
    
    //MARK: - Properties
    var viewModel: SearchCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView = UIImageView()
    
    private let userNameLabel: CustomLabel = {
        let l = CustomLabel(text: "joker",textColor: .black,systemfont: UIFont.boldSystemFont(ofSize: 16),alignment: .left)
        
        return l
    }()
    
    private let fullNameLabel: CustomLabel = {
        let l = CustomLabel(text: "Heath Ledger",textColor: .black,systemfont: UIFont.systemFont(ofSize: 14),alignment: .left)
        
        return l
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helperse
    func configureUI() {
        contentView.addSubview(profileImageView)
        profileImageView.centerY(inView: self,
                                 leftAnchor: leftAnchor,
                                 paddingLeft: 4)
        profileImageView.setDimensions(height: 44, width: 44)
        profileImageView.layer.cornerRadius = 22
        profileImageView.clipsToBounds      = true

        let stack = UIStackView(arrangedSubviews: [userNameLabel,
                                                   fullNameLabel])
        contentView.addSubview(stack)
        stack.axis         = .vertical
        stack.distribution = .fillEqually
        stack.spacing      = 2
        stack.anchor(top: topAnchor,
                     left: profileImageView.rightAnchor,
                     paddingTop: 4,paddingLeft: 8)
    }
    
    func configure() {
        guard let viewModel else { return }
        profileImageView.setImage(stringURL: viewModel.profileImage)
        fullNameLabel.text = viewModel.fullName
        userNameLabel.text = viewModel.userName
    }
}
