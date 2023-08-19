//  EditProfileController.swift
//  TwitterClone
//  Created by Erkan Emir on 06.07.23.

import UIKit

class EditProfileController: UIViewController {
    
    private lazy var c = CustomCollectionView(scroll: .horizontal, spacing: 4,
                                              delegate: self, dataSource: self)
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Edit Profile"
    }
}

extension EditProfileController: UICollectionViewDelegate { }

extension EditProfileController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
