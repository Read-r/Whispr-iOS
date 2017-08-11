//
//  NotificationViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-10.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var dismissed : Bool = false
    var notificationRect: CGRect = CGRect.zero
    
    var position : NotificationController.Position = .top
    
    var notificationText : String {
        get {
            guard   let notificationView = view as? NotificationView,
                    let text = notificationView.notificationLabel.text else {
                return ""
            }
            
            return text
        }
        set {
            guard let notificationView = view as? NotificationView else {
                return
            }
            
            notificationView.notificationLabel.text = newValue
        }
    }
    
    init(_ rect:CGRect) {
        super.init(nibName: nil, bundle: nil)
        
        notificationRect = rect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NotificationView(frame: notificationRect)
        view.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSwipe))
        gestureRecognizer.direction = .right
        
        //view.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSwipe(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delegate = self
        
        
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func dismissSwipe(_ recognizer:UIGestureRecognizer) {
        NotificationController.dismiss(notification: self)
    }
}
