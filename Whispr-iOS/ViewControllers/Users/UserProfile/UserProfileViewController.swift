//
//  UserProfileViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-08.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    var user : User? = nil
    var delegate : UserBrowseAndPickDelegate? = nil
    
    init(displayUser user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UserProfileView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickButton = UIBarButtonItem(title: "Pick", style: .plain, target: self, action: #selector(userPickedAction(_:)))
        navigationItem.rightBarButtonItem = pickButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userToShow = user {
            self.navigationItem.title = userToShow.name
        }
    }
    
    @objc func userPickedAction(_ sender: Any) {
        guard   let del = delegate,
                let userToPick = user,
                let presentingVC = presentingViewController else {
            return
        }
        
        del.userPicked(userToPick)
        
        presentingVC.dismiss(animated: true, completion: nil)
    }
}
