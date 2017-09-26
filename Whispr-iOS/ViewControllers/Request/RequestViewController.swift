//
//  RequestViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    
    var simpleRequestButton: UIButton {
        let requestView = view as! RequestView
        
        return requestView.simpleTextRequestButton
    }
    
    override func loadView() {
        view = RequestView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleRequestButton.addTarget(self, action: #selector(startSimpleRequest), for: .touchUpInside)
    }
    
    @objc private func startSimpleRequest() {
        let newVC = CreateTextRequestViewController()
        
        let navController = UINavigationController(rootViewController: newVC)
        
        present(navController, animated: true, completion: nil)
    }
}
