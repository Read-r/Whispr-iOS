//
//  DatePickerTableViewCell.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        return picker
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviewForAutolayout(datePicker)
        datePicker.topAnchor.constraint(equalTo: topAnchor).activate()
        datePicker.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
