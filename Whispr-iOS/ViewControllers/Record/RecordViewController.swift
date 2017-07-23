//
//  RecordViewController.swift
//  ReadMe
//
//  Created by Mikael Sundström on 2017-07-23.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    var recorder : Recorder = AVFoundationRecorder()

    override func viewDidLoad() {
        super.viewDidLoad()

        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord, with:.defaultToSpeaker)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if self.recorder.isRecording() {
            self.recorder.stopRecording()
        }
        else {
            self.recorder.record()
        }
    }
    
}
