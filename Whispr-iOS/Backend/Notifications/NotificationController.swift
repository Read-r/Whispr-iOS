//
//  NotificationController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-10.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class NotificationController: NSObject {
    
    static private let margin: CGFloat = 10.0
    
    enum Position {
        case top
        case bottom
    }
    
    static func displayNotification(_ text:String, position:Position) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        var rect = CGRect(x: NotificationController.margin, y: NotificationController.margin, width: UIScreen.main.bounds.width - (NotificationController.margin * 2.0), height: 40)
        
        var baseRect = rect
        
        switch position {
        case .bottom:
            baseRect.origin = CGPoint(x: NotificationController.margin, y: window.bounds.size.height + rect.size.height)
            rect.origin.y = window.bounds.size.height - rect.size.height - NotificationController.margin
            break
        case .top: fallthrough
        default:
            baseRect.origin = CGPoint(x: NotificationController.margin, y: 0 - rect.size.height)
            rect.origin.y = NotificationController.margin + 20
            break
        }
        
        let notification = NotificationViewController(rect)
        notification.notificationText = text
        notification.position = position
        
        notification.view.frame = baseRect
        notification.view.alpha = 0.0
        
        window.addSubview(notification.view)
        window.bringSubview(toFront: notification.view)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .allowUserInteraction, animations: {
            notification.view.frame = rect
            notification.view.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, animations: {
            notification.view.frame = rect
        }, completion: { (bool) in
            NotificationController.dismiss(notification: notification)
        })
    }
    
    static func dismiss(notification:NotificationViewController) {
        var destinationRect = CGRect(x: NotificationController.margin, y: 0 - notification.view.bounds.height, width: UIScreen.main.bounds.width - (NotificationController.margin * 2.0), height: notification.view.bounds.height)
        
        switch notification.position {
        case .bottom:
            if let window = UIApplication.shared.keyWindow {
                destinationRect.origin.y = window.bounds.size.height + notification.view.bounds.height
            }
            else {
                fallthrough
            }
            break
        case .top: fallthrough
        default:
            destinationRect = CGRect(x: NotificationController.margin, y: 0 - notification.view.bounds.height, width: UIScreen.main.bounds.width - (NotificationController.margin * 2.0), height: notification.view.bounds.height)
        }
        
        UIView.animate(withDuration: 0.25, delay: 5.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            guard !notification.dismissed else {
                return
            }
            
            notification.view.frame = destinationRect
            notification.view.alpha = 0.0
        }, completion: { (bool) in
            guard !notification.dismissed else {
                return
            }
            
            notification.view.removeFromSuperview()
        })
    }
}
