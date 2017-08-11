//
//  NotificationView.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-10.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    let notificationLabel : UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.blue
        label.text = "aslkdjaslkdjaslkdj"
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        isUserInteractionEnabled = true
        
        addSubviewForAutolayout(notificationLabel)
        notificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        notificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        notificationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        set(cornerRadius: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
