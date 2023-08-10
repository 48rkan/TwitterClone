//  LoginController.swift
//  TwitterClone
//  Created by Erkan Emir on 21.06.23.

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    var viewModel = LoginViewModel()
    
    private let twitterLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = Assets.twitterLogo.image()
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private let emailContainerView    = CustomContainerView(image: Assets.mail.image(),
                                                            placeholder: "Email")
    
    private let passwordContainerView = CustomContainerView(image: Assets.lock.image(),
                                                            placeholder: "Password",
                                                            secure: true)
    
    private lazy var logInButton: CustomButton = {
        let b = CustomButton(backgroundColor: .white ,title: "Log in",
                             titleColor: .twitterBlue, size: 20,
                             cornerRadius: 5)
        b.addTarget(self, action: #selector(tappedLogInButton), for: .touchUpInside)
        b.isEnabled = false

        return b
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let b = UIButton()
        b.setButtonConfiguration(firstText: "Don't have an account?",firstTextColor: .white, secondText: " Sign up",secondTextColor: .white)
        b.addTarget(self, action: #selector(tappedGoRegister), for: .touchUpInside)
        return b
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configDelegates()
    }
    
    //MARK: - Actions
    @objc func tappedGoRegister() {
//        print("tappedAccountButton ")
        let controller = RegisterController()
        navigationController?.show(controller, sender: nil)
    }
    
    @objc func tappedLogInButton() {
        guard let email    = emailContainerView.textField.text    else { return }
        guard let password = passwordContainerView.textField.text else { return }
        
        viewModel.logUserIn(email: email, password: password) { _, error in
            if error != nil {
                self.showMessage(withTitle: error?.localizedDescription ?? "")
                return
            }

            guard let window = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last else { return }
            guard let tabBar = window.rootViewController as? MainTabBarController else { return }
            
            tabBar.checkAuthenticateUser()
            
            self.dismiss(animated: true)
        }
    }
}

//MARK: - Helpers
extension LoginController {
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true

        view.backgroundColor = .twitterBlue
        
        view.addSubview(twitterLogo)
        twitterLogo.centerX(inView: view,
                            topAnchor: view.safeAreaLayoutGuide.topAnchor,
                            paddingTop: 8)
        twitterLogo.setDimensions(height: 150, width: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,logInButton])
        view.addSubview(stack)
        stack.anchor(top: twitterLogo.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 8,paddingLeft: 8,paddingRight: 8)
        stack.setHeight(160)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing      = 16
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
    }
    
    func configDelegates() {
        emailContainerView.delegate    = self
        passwordContainerView.delegate = self
    }
}

extension LoginController: CustomContainerViewDelegate {
    
    func didChangeTextField(sender: UITextField, text: String) {
        switch sender {
        case emailContainerView.textField:
            viewModel.email = text
        case passwordContainerView.textField:
            viewModel.password = text
        case _:
            break
        }
        
        logInButton.backgroundColor = viewModel.configBackgroundColor
        updateForm()
    }
    
    func updateForm() {
        if viewModel.formIsValid {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
    }
}
