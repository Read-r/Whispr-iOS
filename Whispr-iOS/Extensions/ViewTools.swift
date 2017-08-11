//
//  View.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-10.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewForAutolayout(_ subview:UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
    
    func set(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
