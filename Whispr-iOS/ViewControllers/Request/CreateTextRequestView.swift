//
//  CreateTextRequestView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-19.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class CreateTextRequestView: UIView {
    
    struct Layout {
        static let topSpacing: CGFloat = 0.0
        static let leadingSpacing: CGFloat = 0.0
        static let trailingSpacing: CGFloat = 0.0
        static let bottomSpacing: CGFloat = 0.0
    }
    
    let cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Cancel"
        
        return button
    }()
    
    let nextBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Next"
        
        return button
    }()
    
    let textView: UITextView = {
        let textview = UITextView()
        
        return textview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        textView.contentInsetAdjustmentBehavior = .never
        
        addSubviewForAutolayout(textView)
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:Layout.bottomSpacing).activate()
        textView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.topSpacing).activate()
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.leadingSpacing).activate()
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.trailingSpacing).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func safeAreaInsetsDidChange() {
        textView.contentInset = safeAreaInsets
    }
}
