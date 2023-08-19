//  TweetController.swift
//  TwitterClone
//  Created by Erkan Emir on 12.07.23.

import UIKit

class TweetController: UIViewController {
    
    //MARK: - Properties
    var viewModel: TweetViewModel

    private lazy var collection: CustomCollectionView2 = {
        let c = CustomCollectionView2(scroll: .vertical, spacing: 4,
                                      delegate: self, dataSource: self,
                                      registerCell  : FeedCell.self,
                                      registerHeader: TweetHeader.self)
        return c
    }()
        
    private lazy var actionSheetLauncher: ActionSheetLauncher = {
        let a = ActionSheetLauncher(viewModel: ActionViewModel(user: viewModel.user,
                                                               tweetID: viewModel.tweetID))
        a.delegate = self
        return a
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
        viewModel.callBack = { self.collection.reloadData() }
    }
}

//MARK: - Helpers
extension TweetController {
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Detail"
        navigationController?.navigationBar.tintColor = .black
        
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
        viewModel.replies.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(FeedCell.self)", for: indexPath) as! FeedCell
        cell.viewModel = FeedCellViewModel(items: viewModel.replies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(TweetHeader.self)", for: indexPath) as! TweetHeader
        header.delegate  = self
        header.viewModel = TweetHeaderViewModel(tweet: viewModel.tweet)
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TweetController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = dynamicHeightCalculator(text: viewModel.tweet.text,
                                             width: view.frame.width) + 260
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 100)
    }
}

//MARK: - TweetHeaderDelegate
extension TweetController: TweetHeaderDelegate {
    func wantsToLikeOrUnlike(_ header: TweetHeader, tweet: Tweet) {
        var tweet = tweet
        tweet.liked.toggle()
        
        if tweet.liked {
            header.likeButton.setImage(Assets.like_filled.image(), for: .normal)
            header.likeButton.tintColor = .red
            TweetService.likeTweet(tweet: tweet) { _ in
                self.viewModel.checkTweetIfLiked(tweet: tweet)
            }
        } else {
            header.likeButton.setImage(Assets.like_unselected.image(), for: .normal)
            TweetService.unLikeTweet(tweet: tweet) { _ in
                self.viewModel.checkTweetIfLiked(tweet: tweet)
            }
        }
    }
        
    func wantsToReplies(_ header: TweetHeader) {
        guard let tweet = header.viewModel?.tweet else { return }
        
        let controller = UploadController(viewModel: UploadViewModel(configuration: .replies(tweet)))
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func showActionLauncher() { actionSheetLauncher.show() }
}

//MARK: - ActionSheetLauncherDelegate
extension TweetController: ActionSheetLauncherDelegate {
    func didSelect(_ option: ActionSheetOptions) {
        switch option {
        case .follow(let user):
            UserService.follow(uid: user.uid)   { error in }
        case .unfollow(let user):
            UserService.unfollow(uid: user.uid) { error in }
        case .delete(let tweetID):
            TweetService.deleteTweet(tweetID: tweetID)
        case .report:
            print("report called")
        }
    }
}

//MARK: - UploadControllerDelegate
extension TweetController: UploadControllerDelegate {
    func controller(_ postUpdateDidComplete: UIViewController) { }
    
    func controller(_ reloadCollection: UploadController) {
        viewModel.fetchReplies()
        self.collection.reloadData()
    }
}
