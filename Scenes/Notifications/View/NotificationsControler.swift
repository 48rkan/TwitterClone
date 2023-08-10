//  NotificationsControler.swift
//  TwitterClone
// Created by Erkan Emir on 20.06.23.

import UIKit

class NotificationsControler: UIViewController {
    
    //MARK: - Properties
    var viewModel = NotificationViewModel()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate        = self
        t.dataSource      = self
        t.rowHeight       = 60
        t.separatorStyle  = .none
        t.register(NotificationCell.self,
                   forCellReuseIdentifier: "\(NotificationCell.self)")
        return t
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureUI() {
        navigationItem.title = "Notification"
        
        view.addSubview(table)
        table.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.rightAnchor,
                     paddingTop: 0,paddingLeft: 0,
                     paddingBottom: 0,paddingRight: 0)
    }
}

//MARK: - UITableViewDelegate
extension NotificationsControler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = viewModel.notifications[indexPath.row]
        guard let postId = notification.postId else { return }
        
        TweetService.fetchSelectedTweet(tweetID: postId) { tweet in
            let controller = TweetController(viewModel: TweetViewModel(tweet: tweet))
            self.navigationController?.show(controller, sender: nil)
        }
    }
}

//MARK: - UITableViewDataSource
extension NotificationsControler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(NotificationCell.self)", for: indexPath) as! NotificationCell
        cell.viewModel = NotificationCellViewModel(notification: viewModel.notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK: - NotificationCellDelegate
extension NotificationsControler: NotificationCellDelegate {
    func didTapProfile(_ cell: NotificationCell) {
        guard let uid = cell.viewModel?.notification.uid else { return }
        UserService.fetchSelectedUser(userUid: uid) { user in
            let controller = ProfileController(viewModel: ProfileViewModel(user: user))
            self.navigationController?.show(controller, sender: nil)
        }
    }
}
