//
//  MainTabController.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-17.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [listenTab(), recordTab(), requestTab()]
    }
    
    private func listenTab() -> UIViewController {
        let listenVC = SavedAudioViewController()
        
        let navController = UINavigationController(rootViewController: listenVC)
        navController.tabBarItem = UITabBarItem(title: "Listen", image: nil, selectedImage: nil)
        
        return navController
    }
    
    private func recordTab() -> UIViewController {
        let recordVC = TakenJobsViewController()
        
        recordVC.tabBarItem = UITabBarItem(title: "Record", image: nil, selectedImage: nil)
        
        return recordVC
    }
    
    private func requestTab() -> UIViewController {
        let requestVC = RequestViewController()
        
        requestVC.tabBarItem = UITabBarItem(title: "Request", image: nil, selectedImage: nil)
        
        return requestVC
    }
}
