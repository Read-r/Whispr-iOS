//
//  FilteringView.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-13.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class FilteringView: UIView {
    let filterRecorderLabel: UILabel = {
        let label = UILabel()
        label.text = "Include recorded"
        label.sizeToFit()
        
        return label
    }()
    
    let filterRecorderSwitch: UISwitch = {
        let switchButton = UISwitch()
        
        return switchButton
    }()
    
    let filterDownloadedLabel: UILabel = {
        let label = UILabel()
        label.text = "Include downloaded"
        label.sizeToFit()
        
        return label
    }()
    
    let filterDownloadedSwitch: UISwitch = {
        let switchButton = UISwitch()
        
        return switchButton
    }()
    
    private var filters = [String:(UILabel,UISwitch)]()
    
    init(_ options:[String]) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
  
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            backgroundColor = UIColor.blue
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.frame = bounds
            
            addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            backgroundColor = UIColor.black
        }
        
        for option in options {
            let label = UILabel()
            label.text = option
            label.sizeToFit()
            addSubviewForAutolayout(label)
            
            let switchButton = UISwitch()
            addSubviewForAutolayout(switchButton)
            
            filters[option] = (label,switchButton)
        }
        
        if filters.count > 0 {
            var option = filters[0].value
            
            option.1.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            option.1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
            option.0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            option.0.centerYAnchor.constraint(equalTo: option.1.centerYAnchor).isActive = true
            
            if filters.count > 2 {
                for i in 1..<filters.count-1 {
                    let prevOption = filters[i-1].value
                    option = filters[i].value
                    
                    option.1.topAnchor.constraint(equalTo: prevOption.1.bottomAnchor, constant: 5).isActive = true
                    option.1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
                    
                    option.0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
                    option.0.centerYAnchor.constraint(equalTo: option.1.centerYAnchor).isActive = true
                }
                
                let prevOption = filters[1].value
                option = filters[filters.count-1].value
                
                option.1.topAnchor.constraint(equalTo: prevOption.1.bottomAnchor, constant: 5).isActive = true
                option.1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
                option.1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
                
                option.0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
                option.0.centerYAnchor.constraint(equalTo: option.1.centerYAnchor).isActive = true
            }
            else if filters.count == 2 {
                let prevOption = filters[0].value
                option = filters[1].value
                
                option.1.topAnchor.constraint(equalTo: prevOption.1.bottomAnchor, constant: 5).isActive = true
                option.1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
                option.1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
                
                option.0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
                option.0.centerYAnchor.constraint(equalTo: option.1.centerYAnchor).isActive = true
            }
            
            frame.size.height = CGFloat(filters.count)*filterDownloadedSwitch.bounds.size.height + 25
        }
        
        /*
        addSubviewForAutolayout(filterRecorderLabel)
        addSubviewForAutolayout(filterRecorderSwitch)
        addSubviewForAutolayout(filterDownloadedLabel)
        addSubviewForAutolayout(filterDownloadedSwitch)
        
        filterRecorderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        filterRecorderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        filterRecorderLabel.widthAnchor.constraint(equalToConstant: filterRecorderLabel.bounds.width).isActive = true
        
        filterRecorderSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        filterRecorderSwitch.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        filterDownloadedSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        filterDownloadedSwitch.topAnchor.constraint(equalTo: filterRecorderSwitch.bottomAnchor, constant: 5).isActive = true
        filterDownloadedSwitch.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        filterDownloadedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        filterDownloadedLabel.centerYAnchor.constraint(equalTo: filterDownloadedSwitch.centerYAnchor).isActive = true
        filterDownloadedLabel.widthAnchor.constraint(equalToConstant: filterDownloadedLabel.bounds.width).isActive = true
        
        */
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
