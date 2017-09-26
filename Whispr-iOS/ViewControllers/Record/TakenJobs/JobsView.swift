//
//  JobsView.swift
//  Whispr-iOS
//
//  Created by Mikael on 2017-09-19.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class JobsView: UIView {

    var tableView: UITableView = {
        let tableview = UITableView()
        
        
        return tableview
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviewForAutolayout(tableView)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).activate()
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
