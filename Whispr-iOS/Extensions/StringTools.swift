//
//  StringTools.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-07-31.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

extension String {
    
    var nib : UINib {
        return UINib.init(nibName: self, bundle: nil)
    }
}
