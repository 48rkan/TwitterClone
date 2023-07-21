//  ActionSheetCell.swift
//  TwitterClone
//  Created by Erkan Emir on 19.07.23.

import UIKit

class ActionSheetCell: UITableViewCell {
    
    //MARK: - Properties
    var viewModel: ActionSheetCellViewModel? {
        didSet {
            configure()
        }
    }
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = Assets.twitterLogoBlue.image()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.red
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helper & Actions
    func configure() {
        titleLabel.text = viewModel?.item.description
    }
    
    func configureUI() {
        contentView.addSubview(iconImageView)
        iconImageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 8)
        iconImageView.setDimensions(height: 36, width: 36)
        
        contentView.addSubview(titleLabel)
        titleLabel.centerY(inView: self, leftAnchor: iconImageView.rightAnchor,paddingLeft: 12)

    }

}
