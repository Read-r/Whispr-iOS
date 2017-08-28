//
//  Recorder.swift
//  ReadMe
//
//  Created by Mikael Sundström on 2017-07-22.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class Recorder: NSObject {
    
    static var baseURL : URL {
        let dirPaths = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)
        
        let base = dirPaths[0].appendingPathComponent("audio", isDirectory: true)
        
        
        // first time setup
        var isDirectory : ObjCBool = true
        if !FileManager.default.fileExists(atPath: base.absoluteString, isDirectory: &isDirectory) {
            do {
                try FileManager.default.createDirectory(at: base, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                print("\(error.localizedDescription)")
            }
        }
        
        let recorded = base.appendingPathComponent("recorded", isDirectory:true)
        if !FileManager.default.fileExists(atPath: recorded.absoluteString, isDirectory: &isDirectory) {
            do {
                try FileManager.default.createDirectory(at: recorded, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                print("\(error.localizedDescription)")
            }
        }
        
        return recorded
    }
    
    var fileURL : URL? {
        
        guard fileName != "" else {
            return nil
        }
        
        return Recorder.baseURL.appendingPathComponent(fileName)
    }
    
    var fileName : String = ""
    
    func setup() -> Bool {
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
