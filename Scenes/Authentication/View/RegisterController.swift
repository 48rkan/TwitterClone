//
//  RegisterController.swift
//  TwitterClone
//
//  Created by Erkan Emir on 21.06.23.
//

import UIKit

class RegisterController: UIViewController {
    
    //MARK: - Properties
    var viewModel = RegisterViewModel()
    
    private lazy var plusButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(Assets.plus.image(), for: .normal)
        b.tintColor = .white
        b.addTarget(self, action: #selector(tappedAddPhoto), for: .touchUpInside)
        return b
    }()
    
    private let emailContainerView    = CustomContainerView(image: Assets.mail.image(),
                                                            placeholder: "Email")
    
    private let passwordContainerView = CustomContainerView(image: Assets.lock.image(),
                                                            placeholder: "Password",
                                                            secure: true)
    
    private let fullNameContainerView = CustomContainerView(image: Assets.person.image(),
                                                            placeholder: "Full Name")
    
    private let userNameContainerView = CustomContainerView(image: Assets.person.image(),
                                                            placeholder: "Username")
        
    private lazy var signUpButton: CustomButton = {
        let b = CustomButton(backgroundColor: .white ,title: "Sign up",
                             titleColor: .twitterBlue, size: 20,
                             cornerRadius: 5)
        b.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        b.isEnabled = false
        return b
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let b = UIButton()
        b.setButtonConfiguration(firstText: "Already have an account?", secondText: " Log in")
        b.addTarget(self, action: #selector(tappedGoLoginScene), for: .touchUpInside)
        return b
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configDelegates()
    }
    
    //MARK: - Actions
    @objc func tappedAddPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func tappedSignUpButton() {
        guard let email    = emailContainerView.textField.text                  else { return }
        guard let password = passwordContainerView.textField.text               else { return }
        guard let fullName = fullNameContainerView.textField.text               else { return }
        guard let userName = userNameContainerView.textField.text?.lowercased() else { return }
        guard let image    = viewModel.selectedImage                            else { return }
        
        self.showLoader(true)
        viewModel.registerUser(credential: AuthCredential(email: email,
                                                          password: password,
                                                          fullname: fullName,
                                                          username: userName,
                                                          profileImage: image)) { error in
            
            self.showMessage(withTitle: error?.localizedDescription ?? "Success")
            self.showLoader(false)
            if error != nil { return }
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) { self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func tappedGoLoginScene() { navigationController?.popViewController(animated: true) }
}

//MARK: - Helpers
extension RegisterController {
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        view.addSubview(plusButton)
        plusButton.centerX(inView: view,topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 4)
        plusButton.setDimensions(height: 120, width: 120)
        plusButton.layer.cornerRadius = 60
        plusButton.clipsToBounds = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   userNameContainerView,
                                                   signUpButton])
        view.addSubview(stack)
        stack.anchor(top: plusButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 4,paddingLeft: 8,
                     paddingRight: 8)
        stack.setHeight(240)
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 4,paddingBottom: 4,paddingRight: 4)
    }
    
    func configDelegates() {
        emailContainerView.delegate    = self
        passwordContainerView.delegate = self
        userNameContainerView.delegate = self
        fullNameContainerView.delegate = self
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension RegisterController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectImage = info[.editedImage] as? UIImage else { return }
        viewModel.selectedImage = selectImage
        
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        plusButton.setImage(selectImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        plusButton.layer.borderColor = UIColor.white.cgColor
        plusButton.layer.borderWidth = 2
        
        dismiss(animated: true)
    }
}

extension RegisterController: CustomContainerViewDelegate {
    func didChangeTextField(sender: UITextField, text: String) {
        
        switch sender {
        case emailContainerView.textField:
            viewModel.email = text
        case passwordContainerView.textField:
            viewModel.password = text
        case userNameContainerView.textField:
            viewModel.userName = text
        case fullNameContainerView.textField:
            viewModel.fullName = text
        case _ :
            break
        }
        
        signUpButton.backgroundColor = viewModel.configBackgroundColor
        updateForm()
    }
    
    func updateForm() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}
