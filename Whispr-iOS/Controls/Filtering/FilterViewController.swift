//
//  FilterViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-11.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

/**
 
 */

protocol FilterViewDelegate {
    func didToggleFilter(withName name:String, toState state:Bool)
}

class FilterViewController: UIViewController {
    
    var blur: Bool {
        set {
            guard let filterView = view as? FilteringView else {
                return
            }
            
            if  newValue &&
                !UIAccessibilityIsReduceTransparencyEnabled() {
                filterView.isBlurred = true
            }
            else {
                filterView.isBlurred = false
            }
        }
        get {
            guard let filterView = view as? FilteringView else {
                return false
            }
            
            return filterView.isBlurred
        }
    }
    
    var delegate: FilterViewDelegate? = nil {
        didSet {
            guard let filterView = view as? FilteringView else {
                return
            }
            
            filterView.delegate = self.delegate
        }
    }
    
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
