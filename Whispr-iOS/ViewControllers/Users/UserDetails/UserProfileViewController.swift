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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userToShow = user {
            self.navigationItem.title = userToShow.name
        }
    }
    
    @IBAction func userPickedAction(_ sender: Any) {
        guard   let del = delegate,
                let userToPick = user,
                let presentingVC = presentingViewController else {
            return
        }
        
        del.userPicked(userToPick)
        
        presentingVC.dismiss(animated: true, completion: nil)
    }
}
