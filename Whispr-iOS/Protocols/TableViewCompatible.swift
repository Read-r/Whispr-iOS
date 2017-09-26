//
//  TableViewCompatible.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

protocol TableViewCompatible {
    var reuseIdentifier : String { get }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}
