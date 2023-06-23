//
//  UploadController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 23.06.23.

import UIKit

class UploadController: UIViewController {
    
    //MARK: - Properties
    var viewModel = UploadViewModel()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor  = .red
        iv.clipsToBounds    = true
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .red
        tv.text = "asdda"
        return tv
    }()
    
    //MARK: - Lifecycle
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
        print("OK")
    }
}

//MARK: - Helpers
extension UploadController {
    
    private func configureUI() {
        view.backgroundColor = .lightGray
        
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
        
        let b = CustomButton(backgroundColor: .twitterBlue,
                             title: "Tweet", titleColor: .white,
                             size: 16,cornerRadius: 16)
        b.setDimensions(height: 32, width: 64)
        b.titleLabel?.textAlignment = .center
        b.addTarget(self, action: #selector(tappedTweetButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: b)
    }
    
}
