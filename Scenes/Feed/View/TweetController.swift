//
//  TweetController.swift
//  TwitterClone
//  Created by Erkan Emir on 12.07.23.

import UIKit

class TweetController: UIViewController {
    
    //MARK: - Properties
    var viewModel: TweetViewModel
    
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.delegate   = self
        c.dataSource = self
        c.backgroundColor = .red
        c.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(TweetHeader.self)")
        
        return c
    }()
    
    //MARK: - Lifecycle
    init(viewModel: TweetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
}

//MARK: - Helpers
extension TweetController {
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(collection)
        collection.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          paddingTop: 4,paddingLeft: 4,
                          paddingBottom: 4,paddingRight: 4)
    }
}

//MARK: - UICollectionViewDelegate
extension TweetController: UICollectionViewDelegate { }

//MARK: - UICollectionViewDataSource
extension TweetController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(TweetHeader.self)", for: indexPath) as! TweetHeader
        header.viewModel = TweetHeaderViewModel(tweet: viewModel.tweet)
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TweetController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = dynamicHeightCalculator(text: viewModel.tweet.text,
                                             width: view.frame.width) + 240
        
        return CGSize(width: view.frame.width, height: height)
    }
}
