//
//  RequestOptionsView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-23.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class RequestOptionsView: UIView {
    
    let tableView: UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .grouped)
        
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubviewForAutolayout(tableView)
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
        tableView.topAnchor.constraint(equalTo: topAnchor).activate()
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
