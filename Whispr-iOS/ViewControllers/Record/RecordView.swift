//
//  RecordView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-19.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class RecordView: UIView {
    var recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Record", for: .normal)
        button.backgroundColor = UIColor.yellow
        
        return button
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.yellow
        
        return button
    }()
    
    var textView: UITextView = {
        let textview = UITextView()
        
        
        return textview;
    }()
    
    var durationLabel: UILabel = {
        let label = UILabel()
        
        
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        addSubviewForAutolayout(recordButton)
        addSubviewForAutolayout(dismissButton)
        addSubviewForAutolayout(textView)
        addSubviewForAutolayout(durationLabel)
        
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150).isActive = true
        
        dismissButton.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        durationLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 40).isActive = true
        durationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        recordButton.topAnchor.constraint(equalTo: durationLabel.bottomAnchor).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
