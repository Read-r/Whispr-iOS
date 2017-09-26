//
//  ViewControllerTools.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-08.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

extension UIViewController {
    //func dismissIfPresenting
    
    func contentInsets() -> UIEdgeInsets {
        var insets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        if !UIApplication.shared.isStatusBarHidden {
            insets.top += UIApplication.shared.statusBarFrame.height
        }
        
        if let navBarBounds = navigationController?.navigationBar.bounds {
            insets.top += navBarBounds.height
        }
        
        if let tabbarBounds = tabBarController?.tabBar.bounds {
            insets.bottom += tabbarBounds.height
        }
        
        return insets
    }
}
