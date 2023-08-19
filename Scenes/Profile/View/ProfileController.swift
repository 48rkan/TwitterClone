//  ProfileController.swift
//  TwitterClone
//  Created by Erkan Emir on 29.06.23.

import UIKit

class ProfileController: UIViewController {
    
    //MARK: - Properties
    var viewModel: ProfileViewModel
    
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4,
                                     delegate: self, dataSource: self)
        c.layout.sectionInset.top = 4
        c.register(ProfileHeader.self,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                   withReuseIdentifier: "\(ProfileHeader.self)")
        
        c.register(FeedCell.self, forCellWithReuseIdentifier: "\(FeedCell.self)")
        
        return c
    }()
    
    //MARK: - Lifecycle
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel.successCallBack = { self.collection.reloadData() }
        
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        collection.contentInset.bottom = tabBarHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        collection.contentInsetAdjustmentBehavior    = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

//MARK: - Helper
extension ProfileController {
    func configureUI() {
        self.navigationController?.navigationBar.barStyle = .black

        view.addSubview(collection)
        collection.anchor(top: view.topAnchor,left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,
                          paddingTop: 0,paddingLeft: 0,
                          paddingBottom: 4,paddingRight: 0)
    }
}

//MARK: - UICollectionViewDelegate
extension ProfileController: UICollectionViewDelegate { }

//MARK: - UICollectionViewDataSource
extension ProfileController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currentDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(FeedCell.self)", for: indexPath) as! FeedCell
        cell.viewModel = FeedCellViewModel(items: viewModel.currentDataSource[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collection.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "\(ProfileHeader.self)", for: indexPath) as! ProfileHeader
        header.viewModel = ProfileHeaderViewModel(user: viewModel.user)
        header.delegate  = self
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = dynamicHeightCalculator(text: viewModel.currentDataSource[indexPath.row].text,
                                             width: view.frame.width - 2)
        return CGSize(width: view.frame.width - 2, height: height + 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 320)
    }
}

//MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func header(_ didActionUser: ProfileHeader, options: ProfileFilterOptions) {
        viewModel.type = options
    }
  
    func header(_ wantsToDismissal: UICollectionReusableView) {
        navigationController?.popViewController(animated: true)
    }
    
    func header(_ didActionUser: User) {
        if didActionUser.isCurrentUser {
            let controller = EditProfileController()
            navigationController?.show(controller, sender: nil)
        }
        
        else if didActionUser.isFollowing {
            UserService.unfollow(uid: didActionUser.uid) { error in
                self.viewModel.user.isFollowing = false
                self.collection.reloadData()
            }
        }
        
        else {
            UserService.follow(uid: didActionUser.uid) { error in
                self.viewModel.user.isFollowing = true
                self.collection.reloadData()
            }
            
            guard let user = AccountService.instance.currentUser else { return }

            NotificationService.uploadNotification(notificationOwnerUid: viewModel.user.uid,
                                                   fromUser: user,
                                                   notificationtype: .follow)
        }
    }
}
