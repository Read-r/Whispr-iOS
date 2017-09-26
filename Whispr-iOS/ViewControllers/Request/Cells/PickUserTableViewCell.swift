//
//  PickUserTableViewCell.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class PickUserTableViewCell: UITableViewCell {

    var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var arrowLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviewForAutolayout(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).activate()
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).activate()
        
        addSubviewForAutolayout(arrowLabel)
        arrowLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -10).activate()
        arrowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).activate()
        arrowLabel.centerYAnchor.constraint(equalTo: centerYAnchor).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
