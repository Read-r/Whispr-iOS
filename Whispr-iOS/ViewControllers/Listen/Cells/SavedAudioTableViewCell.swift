//
//  SavedAudioTableViewCell.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-07-31.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class SavedAudioTableViewCell: UITableViewCell {

    var label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviewForAutolayout(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
