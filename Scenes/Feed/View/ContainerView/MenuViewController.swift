//  MenuViewController.swift
//  TwitterClone
//  Created by Erkan Emir on 03.07.23.

import UIKit

class MenuViewController: UIViewController {
    
    var viewModel = MenuViewModel()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let fullNameLabel: CustomLabel = {
        let l = CustomLabel(text      : "Eddie Brock",
                            textColor : .black,
                            systemfont: UIFont.boldSystemFont(ofSize: 20))
        return l
    }()
    
    private let userNameLabel: CustomLabel = {
        let l = CustomLabel(text      : "@venom",
                            textColor : .lightGray,
                            systemfont: UIFont.systemFont(ofSize: 16))
        return l
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.register(TableCell.self, forCellReuseIdentifier: "\(TableCell.self)")
        t.rowHeight  = 64
        t.delegate   = self
        t.dataSource = self
        
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel.callBack = {
            self.configure()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor,
                                paddingTop: 4,
                                paddingLeft: 8)
        profileImageView.setDimensions(height: 54, width: 54)
        profileImageView.layer.cornerRadius = 27
        profileImageView.clipsToBounds = true
        
        view.addSubview(fullNameLabel)
        fullNameLabel.anchor(top: profileImageView.bottomAnchor,left: view.leftAnchor,paddingTop: 4,paddingLeft: 8)
        
        view.addSubview(userNameLabel)
        userNameLabel.anchor(top: fullNameLabel.bottomAnchor,left: view.leftAnchor,paddingTop: 4,paddingLeft: 8)
        
        view.addSubview(table)
        table.anchor(top: userNameLabel.bottomAnchor,
                     left: view.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.rightAnchor,
                     paddingTop: 4,paddingLeft: 4,
                     paddingBottom: 4,paddingRight: 4)
    }
    
    func configure() {
        profileImageView.setImage(stringURL: viewModel.profileImage)
        fullNameLabel.text = viewModel.fullName
        userNameLabel.text = viewModel.userName
    }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate { }

//MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuFilterOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(TableCell.self)") as! TableCell
        cell.viewModel = TableCellViewModel(datas: (MenuFilterOptions.allCases[indexPath.row].description,
                                                    MenuFilterOptions.allCases[indexPath.row].imageName))
        return cell
    }
}
