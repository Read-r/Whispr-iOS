//
//  UserTableViewCell.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-08.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    var profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }()
    
    var pickButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Pick", for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviewForAutolayout(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).activate()
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).activate()
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).activate()
        
        addSubviewForAutolayout(profileButton)
        profileButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).activate()
        profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-10).activate()
        profileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).activate()
        profileButton.widthAnchor.constraint(equalToConstant: 50).activate()
        profileButton.heightAnchor.constraint(equalToConstant: 50).activate()
        
        
        addSubviewForAutolayout(pickButton)
        pickButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -10).activate()
        pickButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).activate()
        pickButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).activate()
        pickButton.widthAnchor.constraint(equalToConstant: 50).activate()
        pickButton.heightAnchor.constraint(equalToConstant: 50).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
