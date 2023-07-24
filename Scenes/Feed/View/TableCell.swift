//  TableCell.swift
//  TwitterClone
//  Created by Erkan Emir on 03.07.23.

import UIKit

class TableCell: UITableViewCell {
    
    //MARK: - Properties
    var viewModel: TableCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        
        return l
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI() {
        self.selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        iconImageView.centerY(inView: self)
        iconImageView.setDimensions(height: 24, width: 24)
        
        contentView.addSubview(titleLabel)
        titleLabel.centerY(inView: iconImageView)
        titleLabel.anchor(left: iconImageView.rightAnchor,paddingLeft: 4)
    }
    
    func configure() {
        iconImageView.image = UIImage(systemName: viewModel?.datas.image ?? "")
        iconImageView.tintColor = .black
        titleLabel.text = viewModel?.datas.description
    }
    
}
