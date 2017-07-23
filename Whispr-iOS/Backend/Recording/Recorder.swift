//
//  Recorder.swift
//  ReadMe
//
//  Created by Mikael Sundström on 2017-07-22.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class Recorder: NSObject {
    func setup() {
        fatalError("Must override function \"setup()\"!")
    }
    
    func record() -> Bool {
        fatalError("Must override function \"record()\"!")
    }
    
    func stopRecording() -> Bool {
        fatalError("Must override function \"stopRecording()\"!")
    }
    
    func isRecording() -> Bool {
        fatalError("Must override function \"isRecording()\"!")
    }
    
    func breakdown() {
        #if DEBUG
            print("breakdown is empty")
        #endif
    }
}
