//
//  FilteringView.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-13.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class Filter {
    let filterName: String = ""
    fileprivate var filterLabel : UILabel = UILabel()
    fileprivate var filterSwitch : UISwitch = UISwitch()
}

class FilteringView: UIView {
    var delegate: FilterViewDelegate? = nil
    var isBlurred: Bool {
        set {
            if newValue {
                if  let effectView = blurView,
                    effectView.effect == nil {
                    effectView.effect = UIBlurEffect(style: blurType)
                }
                else if blurView == nil {
                    let blurEffect = UIBlurEffect(style: blurType)
                    let blurEffectView = UIVisualEffectView(frame: bounds)
                    blurEffectView.effect = blurEffect
                    
                    insertSubview(blurEffectView, at: 0)
                    
                    blurView = blurEffectView
                }
            }
            else {
                if let blurLayer = blurView {
                    blurLayer.effect = nil
                }
            }
        }
        get {
            guard let effectView = blurView else {
                return false
            }
            
            return effectView.effect != nil
        }
    }
    
    private struct Spacings {
        static let topMargin: CGFloat = 10.0
        static let bottomMargin: CGFloat = 10.0
        static let rightMargin: CGFloat = 20.0
        static let leftMargin: CGFloat = 20.0
        static let filterSpacing: CGFloat = 5.0
        
        static func verticalMargins() -> CGFloat {
            return topMargin + bottomMargin
        }
    }
    
    private var filters = [Filter]()
    private var blurView: UIVisualEffectView? = nil
    private var blurType: UIBlurEffectStyle = .extraLight
    
    init(_ options:[String]) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
  
        
        
        for option in options {
            let newFilter = Filter()
            newFilter.filterLabel.text = option
            
            addSubviewForAutolayout(newFilter.filterLabel)
            addSubviewForAutolayout(newFilter.filterSwitch)
            
            newFilter.filterSwitch.addTarget(self, action: #selector(switchCallback(_:)), for: .touchUpInside)
            
            filters.append(newFilter)
        }
        
        if filters.count > 0 {
            var option = filters[0]
            
            option.filterSwitch.topAnchor.constraint(equalTo: topAnchor, constant: Spacings.topMargin).isActive = true
            option.filterSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacings.rightMargin).isActive = true
            
            option.filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacings.leftMargin).isActive = true
            option.filterLabel.centerYAnchor.constraint(equalTo: option.filterSwitch.centerYAnchor).isActive = true
            
            var i = 1
            while i < filters.count {
                let prevOption = filters[i-1]
                option = filters[i]
                
                option.filterSwitch.topAnchor.constraint(equalTo: prevOption.filterSwitch.bottomAnchor, constant: Spacings.filterSpacing).isActive = true
                option.filterSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacings.rightMargin).isActive = true
                
                option.filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacings.leftMargin).isActive = true
                option.filterLabel.centerYAnchor.constraint(equalTo: option.filterSwitch.centerYAnchor).isActive = true
                
                i += 1
            }
            
            option = filters[filters.count-1]
            
            option.filterSwitch.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacings.bottomMargin).isActive = true
            
            frame.size.height = CGFloat(filters.count)*filters[0].filterSwitch.bounds.size.height + Spacings.verticalMargins() + (Spacings.filterSpacing * (CGFloat(filters.count)-1))
        }
    }
    
    @objc fileprivate func switchCallback(_ sender:AnyObject) {
        guard   let del = delegate,
                let switchButton = sender as? UISwitch,
                let filter = filters.first(where: {$0.filterSwitch == switchButton}) else {
            return
        }
        
        del.didToggleFilter(withName: filter.filterLabel.text ?? "", toState: switchButton.isOn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
