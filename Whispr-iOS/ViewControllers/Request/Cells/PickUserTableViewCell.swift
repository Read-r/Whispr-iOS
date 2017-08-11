//
//  PickUserTableViewCell.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class PickUserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(withUser user:User?) {
        
        if let newUser = user {
            nameLabel.text = newUser.name
        }
        else {
            nameLabel.text = "No user selected"
        }
        
        nameLabel.sizeToFit()
        
    }
}
