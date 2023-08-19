//  FilterView.swift
//  TwitterClone
//  Created by Erkan Emir on 30.06.23.

import UIKit

protocol FilterViewDelegate: AnyObject {
    func view(_ view: FilterView, didSelect indexPath : IndexPath)
}

class FilterView: UIView {
    
    //MARK: - Properties
    weak var delegate: FilterViewDelegate?
    
//    lazy var collection: CustomCollectionView = {
//        let c = CustomCollectionView(scroll: .horizontal, spacing: 0,
//                                     delegate: self,dataSource: self)
//        c.register(FilterCell.self, forCellWithReuseIdentifier: "\(FilterCell.self)")
//        return c
//    }()
    
    lazy var collection: CustomCollectionView2 = {
        let c = CustomCollectionView2(scroll: .horizontal, spacing: 0,
                                      delegate: self,dataSource: self,registerCell: FilterCell.self)
//        c.register(FilterCell.self, forCellWithReuseIdentifier: "\(FilterCell.self)")
        return c
    }()
    
    private let underLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .twitterBlue
        return v
    }()
                
    override init(frame: CGRect) {
        super.init(frame: frame)
        collection.selectItem(at: IndexPath(item: 0, section: 0),
                              animated: true, scrollPosition: .left)
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}

extension FilterView {
    func configureUI() {
        addSubview(collection)
        collection.addConstraintsToFillView(self)
        
        addSubview(underLineView)
        underLineView.anchor(left: leftAnchor,bottom: bottomAnchor)
        
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        underLineView.setDimensions(height: 2, width: frame.width / count)
    }
}

//MARK: - UICollectionViewDelegate
extension FilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collection.cellForItem(at: indexPath))
        print(collection.cellForItem(at: indexPath)?.frame)
        print(collection.cellForItem(at: indexPath)?.frame.origin)
        print(collection.cellForItem(at: indexPath)?.frame.width)
        print(collection.cellForItem(at: indexPath)?.frame.height)

        delegate?.view(self, didSelect: indexPath)
        
        guard let cell = collection.cellForItem(at: indexPath) as? FilterCell else { return }

        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underLineView.frame.origin.x = xPosition
        }
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
