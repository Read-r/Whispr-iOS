//
//  BrowseUsersViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-08.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

protocol UserBrowseAndPickDelegate {
    func userPicked(_ user:User)
}

class BrowseUsersViewController: UIViewController {

    fileprivate var datasource = [User]()
    var tableview: UITableView {
        let browseView = view as! BrowseUsersView
        
        return browseView.tableView
    }
    
    var delegate : UserBrowseAndPickDelegate? = nil
    
    override func loadView() {
        view = BrowseUsersView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInset = contentInsets()
        tableview.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableview.dataSource = self
        tableview.delegate = self
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction(_:)))
        
        navigationItem.leftBarButtonItem = cancelButton
        
        let user1 = User()
        user1.name = "John Doe"
        
        let user2 = User()
        user2.name = "Sanna Rosén"
        
        datasource.append(user1)
        datasource.append(user2)
        
        tableview.reloadData()
    }
    
    @objc func cancelAction(_ sender: Any) {
        guard let presentingVC = presentingViewController else {
            return
        }
        
        presentingVC.dismiss(animated: true, completion: nil)
    }
    
    func pickButtonAction(_ sender:UIButton) {
        guard   let del = delegate,
                let presentingVC = presentingViewController else {
            return
        }
        let touchPoint = sender.convert(CGPoint.zero, to: tableview)
        
        if let indexPath = tableview.indexPathForRow(at: touchPoint) {
            del.userPicked(datasource[indexPath.row])
            
            presentingVC.dismiss(animated: true, completion: nil)
        }
    }
    
    func profileButtonAction(_ sender:UIButton) {
        guard let navController = navigationController else {
            return
        }
        
        let touchPoint = sender.convert(CGPoint.zero, to: tableview)
        if let indexPath = tableview.indexPathForRow(at: touchPoint) {
            let userProfile = UserProfileViewController(displayUser: datasource[indexPath.row])
            userProfile.delegate = delegate
            
            navController.pushViewController(userProfile, animated: true)
        }
    }
}

extension BrowseUsersViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = datasource[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.pickButton.addTarget(self, action: #selector(pickButtonAction(_:)), for: .touchUpInside)
        cell.profileButton.addTarget(self, action: #selector(profileButtonAction(_:)), for: .touchUpInside)
        
        return cell
    }
}

extension BrowseUsersViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
