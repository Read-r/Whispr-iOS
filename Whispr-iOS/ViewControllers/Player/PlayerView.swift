//
//  PlayerView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-18.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    let progressBar: UISlider = {
        let slider = UISlider()
        
        return slider
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.brown
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubviewForAutolayout(progressBar)
        addSubviewForAutolayout(playButton)
        
        progressBar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.bottomAnchor.constraint(equalTo: progressBar.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
