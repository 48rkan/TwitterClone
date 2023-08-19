//  FilterCell.swift
//  TwitterClone
//  Created by Erkan Emir on 30.06.23.

import UIKit

class FilterCell: UICollectionViewCell {
    
    //MARK: - Properties
    var viewModel: FilterCellViewModel? {
        didSet { configure() }
    }
    
    private let titleLabel: UILabel = {
        let l  = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor     = .lightGray
        l.textAlignment = .center
        return l
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16)
                                         : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}

extension FilterCell {
    func configureUI() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.addConstraintsToFillView(self)
    }
    
    func configure() {
        titleLabel.text = viewModel?.item
    }
}
