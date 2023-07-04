//
//  UploadController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 23.06.23.

import UIKit

protocol UploadControllerDelegate: AnyObject {
    func controller(_ postUpdateDidComplete: UIViewController)
}

class UploadController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: UploadControllerDelegate?
    
    var viewModel = UploadViewModel()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor  = .red
        iv.clipsToBounds    = true
        return iv
    }()
    
    private lazy var textView: CustomTextView = {
        let tv = CustomTextView(text: "Enter caption")
        tv.delegate_ = self
        return tv
    }()
    
    private lazy var tweetButton: CustomButton = {
        let b = CustomButton(backgroundColor: .lightGray,
                             title: "Tweet", titleColor: .white,
                             size : 16     , cornerRadius: 16)
        b.setDimensions(height: 32, width: 64)
        b.titleLabel?.textAlignment = .center
        b.addTarget(self,
                    action: #selector(tappedTweetButton),
                    for: .touchUpInside)
        
        return b
    }()
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configNavigationBar()
        print(AccountService.instance.currentUser?.fullname)

    }
    
    //MARK: - Actions
    @objc private func tappedCancel() {
        dismiss(animated: true)
    }
    
    @objc private func tappedTweetButton() {

        TweetService.uploadTweet(text: textView.text, user: viewModel.user) { error in
            print(error)
        }
        
        dismiss(animated: true)
        delegate?.controller(self)
        print("OK")
    }
}

//MARK: - Helpers
extension UploadController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor,
                                paddingTop: 8,paddingLeft: 8)
        profileImageView.setDimensions(height: 56, width: 56)
        profileImageView.layer.cornerRadius = 28
        profileImageView.setImage(stringURL: viewModel.profilimage)
        
        view.addSubview(textView)
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: profileImageView.rightAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 8,paddingLeft: 4,paddingBottom: 0,paddingRight: 4)
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
