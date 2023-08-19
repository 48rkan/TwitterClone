//  CustomCollectionView.swift
//  Giphy
//  Created by Erkan Emir on 15.05.23.

import UIKit

class CustomCollectionView: UICollectionView {
    
    //MARK: - Properties
    let layout = UICollectionViewFlowLayout()
    
    //MARK: - Lifecycle
    init(scroll    : UICollectionView.ScrollDirection,
         spacing   : CGFloat,
         delegate  : UICollectionViewDelegate,
         dataSource: UICollectionViewDataSource) {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection         = scroll
        layout.minimumLineSpacing      = spacing
        layout.minimumInteritemSpacing = spacing
        
        self.delegate   = delegate
        self.dataSource = dataSource
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helper
    func configureCollectionView() {
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
}

//

import UIKit

class CustomCollectionView2: UICollectionView {
    
    //MARK: - Properties
    let layout = UICollectionViewFlowLayout()
    
    //MARK: - Lifecycle
    init(scroll        : UICollectionView.ScrollDirection,
         spacing       : CGFloat,
         delegate      : UICollectionViewDelegate,
         dataSource    : UICollectionViewDataSource,
         registerCell  : UICollectionViewCell.Type,
         registerHeader: UICollectionReusableView.Type? = nil,
         registerFooter: UICollectionReusableView.Type? = nil ) {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection         = scroll
        layout.minimumLineSpacing      = spacing
        layout.minimumInteritemSpacing = spacing
        
        self.delegate   = delegate
        self.dataSource = dataSource
        
        configureCollectionView()
        
        self.register(registerCell, forCellWithReuseIdentifier: "\(registerCell)")

        if let registerHeader = registerHeader {
            self.register(registerHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(registerHeader.self)")
        }
        
        if let registerFooter = registerFooter {
            self.register(registerFooter, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(registerFooter.self)")
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helper
    func configureCollectionView() {
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
}

//
//private lazy var collection: CustomCollectionView = {
//    let c = CustomCollectionView(scroll: .vertical, spacing: 16)
//
//    c.register(FeedHeader.self,
//               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//               withReuseIdentifier: "\(FeedHeader.self)")
//    c.register(FeedFooter.self,
//               forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//               withReuseIdentifier: "\(FeedFooter.self)")
//    c.register(FeedCell.self,
//               forCellWithReuseIdentifier: "\(FeedCell.self)")
//    c.delegate   = self
//    c.dataSource = self
//    c.contentInset.right  = 8
//    c.contentInset.left   = 8
//    c.backgroundColor = .white
//
//    return c
//}()
