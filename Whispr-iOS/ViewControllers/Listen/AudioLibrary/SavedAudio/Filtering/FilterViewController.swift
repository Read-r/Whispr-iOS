//
//  FilterViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-11.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    private var options : [String]
    
    init(_ options:[String]) {
        self.options = options
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = FilteringView(self.options)
    }
}
