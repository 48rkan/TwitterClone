//  ExploreController.swift
//  TwitterClone
//  Created by Erkan Emir on 20.06.23.

import UIKit

class ExploreController: UIViewController {
    
    //MARK: - Lifecycle
    var viewModel = ExploreViewModel()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.register(SearchCell.self, forCellReuseIdentifier: "\(SearchCell.self)")
        t.rowHeight      = 56
        t.delegate       = self
        t.dataSource     = self
        t.separatorStyle = .none
        return t
    }()
    
    var searchController = UISearchController(searchResultsController: nil)
    var isSearchMode: Bool { searchController.isActive && !searchController.searchBar.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
        viewModel.callBack = { self.table.reloadData() }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCustomizeNavigationController()
    }
}

//MARK: - Helper
extension ExploreController {
    func configureUI() {
        navigationItem.title = "Explore"
        view.addSubview(table)
        table.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.rightAnchor,
                     paddingTop: 4,paddingLeft: 4,
                     paddingBottom: 4,paddingRight: 4)
    }
    
    func configureSearchController() {
        // obscuresBackgroundDuringPresentation - search Controller presentation vaxti arxa fonu gizletsinmi
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext              = false
        navigationItem.searchController         = searchController
        searchController.searchBar.placeholder  = "Search"
        searchController.searchBar.tintColor    = .black
        searchController.searchResultsUpdater   = self
    }
    
    func configureCustomizeNavigationController() {
        self.navigationController!.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}


//MARK: - UITableViewDelegate
extension ExploreController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearchMode ? viewModel.filteredUsers[indexPath.row] : viewModel.users[indexPath.row]
        let controller = ProfileController(viewModel: ProfileViewModel(user: user))
        
        navigationController?.show(controller, sender: nil)
    }
}

//MARK: - UITableViewDataSource
extension ExploreController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearchMode ? viewModel.filteredUsers.count : viewModel.users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(SearchCell.self)") as! SearchCell
        
        let user = isSearchMode ? viewModel.filteredUsers[indexPath.row] : viewModel.users[indexPath.row]
        cell.viewModel = SearchCellViewModel(user: user)
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        print(searchText)
        
        viewModel.filteredUsers = viewModel.users.filter({ user in
            user.fullname.contains(searchText) || user.username.contains(searchText)
        })
        
        table.reloadData()
    }

}
