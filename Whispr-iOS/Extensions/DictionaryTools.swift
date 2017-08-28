//
//  DictionaryTools.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-13.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy:i)]
        }
    }
}
