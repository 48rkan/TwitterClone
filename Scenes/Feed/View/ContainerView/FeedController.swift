//  FeedController.swift
//  TwitterClone
//  Created by Erkan Emir on 20.06.23.

import UIKit

protocol FeedControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class FeedController: UIViewController {
    
    weak var delegate: FeedControllerDelegate?
    var viewModel    = FeedViewModel()
        
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.register(FeedCell.self, forCellWithReuseIdentifier: "\(FeedCell.self)")
        c.delegate   = self
        c.dataSource = self
        
        return c
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden      = false
        navigationController?.navigationBar.barStyle      = .default
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func tappedMenuButton() {
        delegate?.didTapMenuButton()
    }
}

//MARK: - Helpers
extension FeedController {
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        viewModel.reloadCallBack = {
            self.collection.reloadData()
            self.showLoader(false)
        }
        
        configNavigationBarItems()
        configConstraints()
    }
    
    private func configConstraints() {
        view.addSubview(collection)
        collection.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,paddingTop: 4,
                          paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
    }
    
    private func configNavigationBarItems() {
        let iv = Assets.twitterLogoBlue.imageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 44, width: 44)
        navigationItem.titleView = iv
        
        let v = UIImageView()
        v.setDimensions(height: 36, width: 36)
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedMenuButton)))
        v.isUserInteractionEnabled       = true
        v.clipsToBounds                  = true
        v.layer.cornerRadius             = 18
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: v)

        viewModel.callBack = {
            v.setImage(stringURL: self.viewModel.profilimage ?? "")
        }
    }
}

//MARK: - UICollectionViewDelegate
extension FeedController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TweetController(viewModel: TweetViewModel(tweet: viewModel.tweets[indexPath.row]))
        navigationController?.show(controller, sender: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(FeedCell.self)", for: indexPath) as! FeedCell
        cell.delegate  = self
        cell.viewModel = FeedCellViewModel(items: viewModel.tweets[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = dynamicHeightCalculator(text: viewModel.tweets[indexPath.row].text, width: view.frame.width - 2)
        return CGSize(width: view.frame.width - 2, height: height + 96)
    }
}

//MARK: - FeedCellDelegate
extension FeedController: FeedCellDelegate {
    func cell(wantsToShowProfileScene: FeedCell, uid: String) {
        viewModel.fetchSelectedUser(userUid: uid) { user in
            let controller = ProfileController(viewModel: ProfileViewModel(user: user))
            self.navigationController?.show(controller, sender: nil)
        }
    }
    
    func cell(wantsToReplies: FeedCell, uid: String) {
        guard let tweet = wantsToReplies.viewModel?.items else { return }
        let controller = UploadController(viewModel: UploadViewModel(configuration: .replies(tweet)))
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    
//    func cell(wantsToReplies: FeedCell, uid: String) {
//        guard let tweet = wantsToReplies.viewModel?.items else { return }
//        let controller = UploadController(viewModel: UploadViewModel(configuration: .replies(tweet)))
//
//        let nav = UINavigationController(rootViewController: controller)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
//    }
//
//    func cell(wantsToShowProfileScene: FeedCell, ownerUid: String) {
//        viewModel.fetchSelectedUser(userUid: ownerUid) { user in
//            let controller = ProfileController(viewModel: ProfileViewModel(user: user))
//            self.navigationController?.show(controller, sender: nil)
//        }
//    }
}
