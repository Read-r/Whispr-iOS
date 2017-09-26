//
//  SavedAudioView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-17.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class SavedAudioView: UIView {
    let tableview: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    private var filterView : FilterViewController? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviewForAutolayout(tableview)
    
        tableview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func filterToggle(showFilter: Bool) {
        
        DispatchQueue.main.async {
            if showFilter {
                self.filterView = FilterViewController(["options1", "option2", "options3"])
                
                /*
                 The filter view should start by sitting just above the table view.
                 We acheive this by taking the contentInset (since the table can scroll under the navigation bar etc) and converting
                 that position to the superview. That gives us the top of the table view area. Subtract the height of the filter view,
                 and we have a starting position where the filter view cannot be seen and does not rely on knowing whether there is a 
                 navigation bar or not
                */
                let startingOrigin = CGPoint(x:0,
                                             y: self.convert(CGRect(x: 0,
                                                                    y: self.tableview.contentInset.top,
                                                                    width: self.filterView!.view.bounds.width,
                                                                    height: self.filterView!.view.bounds.height),
                                                             to: self.superview).origin.y - self.filterView!.view.bounds.height)
                
                self.filterView?.view.frame.origin = startingOrigin
            }
            
            UIView.animate(withDuration: 0.25, animations: {
                if showFilter {
                    guard self.filterView != nil else {
                        return
                    }
                    
                    self.addSubview((self.filterView?.view)!)
                    
                    let targetOrigin = CGPoint(x:0,
                                               y:self.convert(CGRect(x: 0,
                                                                     y: self.tableview.contentInset.top,
                                                                     width: self.filterView!.view.bounds.width,
                                                                     height: self.filterView!.view.bounds.height),
                                                              to: self.superview).origin.y)
                    
                    self.filterView?.view.frame.origin = targetOrigin
                    
                    self.tableview.contentInset.top += (self.filterView?.view.bounds.height)!
                    self.tableview.scrollIndicatorInsets.top += (self.filterView?.view.bounds.height)!
                    
                    if self.tableview.contentOffset.y < 10 {
                        self.tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    
                    self.filterView?.blur = true
                }
                else {
                    self.tableview.contentInset.top -= (self.filterView?.view.bounds.height)!
                    self.tableview.scrollIndicatorInsets.top -= (self.filterView?.view.bounds.height)!
                    
                    self.filterView?.blur = false
                    self.filterView?.view.frame.origin.y -= (self.filterView?.view.bounds.height)!
                }
            }, completion: { (completion) in
                if !showFilter {
                    self.filterView?.view.removeFromSuperview()
                    self.filterView = nil
                }
            })
        }
    }
}
