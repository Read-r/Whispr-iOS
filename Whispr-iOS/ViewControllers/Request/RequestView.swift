//
//  RequestView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-19.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class RequestView: UIView {

    let simpleTextRequestButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.brown, for: .normal)
        button.setTitle("Simple text Request", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubviewForAutolayout(simpleTextRequestButton)
        
        simpleTextRequestButton.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
        simpleTextRequestButton.centerYAnchor.constraint(equalTo: centerYAnchor).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
