//  FilterView.swift
//  TwitterClone
//  Created by Erkan Emir on 30.06.23.

import UIKit

protocol FilterViewDelegate: AnyObject {
    func view(_ view: FilterView, didSelect indexPath : IndexPath)
}

class FilterView: UIView {
    
    weak var delegate: FilterViewDelegate?
    
    lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .horizontal, spacing: 0)
        c.register(FilterCell.self,
                   forCellWithReuseIdentifier: "\(FilterCell.self)")
        c.delegate   = self
        c.dataSource = self
        
        return c
    }()
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
        collection.selectItem(at: IndexPath(item: 0, section: 0),
                              animated: true,
                              scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}

extension FilterView {
    func configureUI() {
        addSubview(collection)
        collection.addConstraintsToFillView(self)
    }
}

//MARK: - UICollectionViewDelegate
extension FilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.view(self, didSelect: indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension FilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProfileFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(FilterCell.self)", for: indexPath) as! FilterCell
        cell.viewModel = FilterCellViewModel(item: ProfileFilterOptions(rawValue: indexPath.item)?.description ?? "")

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        return CGSize(width: frame.width / count , height: frame.height)
    }
}
