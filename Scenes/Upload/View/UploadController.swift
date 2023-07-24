//  UploadController.swift
//  TwitterClone
//  Created by Erkan Emir on 23.06.23.

import UIKit

protocol UploadControllerDelegate: AnyObject {
    func controller(_ postUpdateDidComplete: UIViewController)
    func controller(_ reloadCollection: UploadController)
}

class UploadController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: UploadControllerDelegate?
    
    var viewModel: UploadViewModel
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor  = .red
        iv.clipsToBounds    = true
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 24
        iv.setImage(stringURL: viewModel.profilimage)
        return iv
    }()
    
    private lazy var textView: CustomTextView = {
        let tv = CustomTextView(text: viewModel.placeHolderText ?? "")
        tv.delegate_ = self
        return tv
    }()
    
    private lazy var tweetButton: CustomButton = {
        let b = CustomButton(backgroundColor: .lightGray,
                             title          : viewModel.buttonTitle ?? "",
                             titleColor     : .white,
                             size           : 16,
                             cornerRadius   : 16)
        b.setDimensions(height: 32, width: 64)
        b.titleLabel?.textAlignment = .center
        b.addTarget(self,
                    action: #selector(tappedTweetButton),
                    for: .touchUpInside)
        return b
    }()
    
    lazy var replyLabel: UILabel = {
        let l = UILabel()
        l.text = viewModel.replyText ?? ""
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = .lightGray
        return l
    }()
    
    //MARK: - Lifecycle
    init(viewModel: UploadViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configNavigationBar()
    }
    
    //MARK: - Actions
    @objc private func tappedCancel() {
        dismiss(animated: true)
    }
    
    @objc private func tappedTweetButton() {
        
        switch viewModel.configuration {
        case .tweet:
            TweetService.uploadTweet(text: textView.text, user: viewModel.user) { _ in  }
            delegate?.controller(self)

        case .replies(let tweet):
            ReplyService.uploadReply(comments: textView.text,
                                     tweetID: tweet.tweetID,
                                     user: viewModel.user) { error in
                print(error)
                self.delegate?.controller(self)
            }
            
        }
        
        dismiss(animated: true)
    }
}

//MARK: - Helpers
extension UploadController {
    
    private func configureUI() {
        view.backgroundColor = .white
 
        let mainStack = UIStackView(arrangedSubviews: [profileImageView,textView])
        view.addSubview(mainStack)
        mainStack.axis         = .horizontal
        mainStack.distribution = .fill
        
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 16,paddingLeft: 16,paddingRight: 16)
        
        let subStack = UIStackView(arrangedSubviews: [replyLabel,mainStack])
        view.addSubview(subStack)
        subStack.axis    = .vertical
        subStack.spacing = 8
        subStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 4,paddingRight: 4)
        
        guard let isHidden  = viewModel.shouldShowReplyLabel else { return }
        replyLabel.isHidden = !isHidden
//        replyLabel.isHidden = true
    }

    private func configNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent   = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tappedCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

//MARK: - CustomTextViewDelegate
extension UploadController: CustomTextViewDelegate {
    func textView(_ textView: CustomTextView) {
        if !textView.text.isEmpty {
            tweetButton.isEnabled       = true
            tweetButton.backgroundColor = .twitterBlue
        } else {
            tweetButton.isEnabled       = false
            tweetButton.backgroundColor = .lightGray
        }
    }
}
