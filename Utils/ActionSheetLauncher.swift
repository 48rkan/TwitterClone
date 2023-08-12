//  ActionSheetLauncher.swift
//  TwitterClone
//  Created by Erkan Emir on 19.07.23.

import UIKit

protocol ActionSheetLauncherDelegate: AnyObject {
    func didSelect(_ option: ActionSheetOptions)
}

class ActionSheetLauncher: NSObject {
    
    //MARK: - Properties
    weak var delegate: ActionSheetLauncherDelegate?
    
    var viewModel: ActionViewModel
    
    private lazy var blackView: UIView = {
        let v   = UIView()
        v.alpha = 0
        v.backgroundColor = UIColor(white: 0, alpha: 0.5)
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissal)))
        v.isUserInteractionEnabled = true
        
        return v
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate        = self
        t.dataSource      = self
        t.backgroundColor = .red
        t.rowHeight       = 60
        t.isScrollEnabled = false
        t.separatorStyle  = .none
        t.register(ActionSheetCell.self, forCellReuseIdentifier: "\(ActionSheetCell.self)")
        
        return t
    }()
    
    private lazy var cancelButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Cancel", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        b.backgroundColor  = .systemGroupedBackground
        b.clipsToBounds    = true
        b.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        b.setTitleColor(.black, for: .normal)

        return b
    }()

    private lazy var footerView: UIView = {
        let v = UIView()
        v.addSubview(cancelButton)
        cancelButton.setHeight(50)
        cancelButton.anchor(left: v.leftAnchor,right: v.rightAnchor,
                            paddingLeft: 12,paddingRight: 12)
        cancelButton.centerY(inView: v)
        cancelButton.layer.cornerRadius = 25
        return v
    }()
    
    //MARK: - Lifecycle
    init(viewModel: ActionViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - Actions
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha       = 0
            self.table.frame.origin.y += 220
        }
    }
    
    //MARK: - Helper
    func show() {
        guard let window = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last else { return }
        
        window.addSubview(blackView)
        blackView.frame = window.frame

        window.addSubview(table)
        let height = CGFloat(3 * 60)
        table.frame = CGRect(x: 0, y: window.frame.height - 40,
                             width: window.frame.width, height: height)
            
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            self.table.frame.origin.y -= height
        }
    }
}

//MARK: - UITableViewDelegate
extension ActionSheetLauncher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(viewModel.type[indexPath.row])
        handleDismissal()
    }
}

//MARK: - UITableViewDataSource
extension ActionSheetLauncher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(ActionSheetCell.self)") as! ActionSheetCell
        cell.viewModel = ActionSheetCellViewModel(item: viewModel.type[indexPath.row])

        return cell
    }
}

//MARK: - UITableViewFooter
extension ActionSheetLauncher {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { footerView }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 60 }
}
