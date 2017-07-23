//
//  AVFoundationRecorder.swift
//  ReadMe
//
//  Created by Mikael Sundström on 2017-07-23.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit
import AVFoundation

class AVFoundationRecorder: Recorder, AVAudioRecorderDelegate {
    
    lazy var audioRecorder : AVAudioRecorder = {
        
        let dirPaths = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.m4a")
        
        let settings =
            [AVFormatIDKey : kAudioFormatMPEG4AAC,
             AVNumberOfChannelsKey: 1,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        var recorder: AVAudioRecorder? = nil
        
        do {
            recorder = try AVAudioRecorder(url: soundFileURL, settings:settings)
        }
        catch {
            print("error")
        }
        
        if let rec = recorder {
            rec.delegate = self
        }
        
        return recorder!
    }()
    
    override func setup() {
        
    }
    
    override func record() -> Bool {
        if self.audioRecorder.prepareToRecord() {
            
            if self.audioRecorder.record() {
                #if DEBUG
                print("recording")
                #endif
                return true
            }
        }
        
        return false
    }
    
    override func stopRecording() -> Bool {
        if self.audioRecorder.isRecording {
            self.audioRecorder.stop()
            #if DEBUG
            print("stopped recording")
            #endif
            return true
        }
        else {
            return false
        }
    }
    
    override func isRecording() -> Bool {
        return self.audioRecorder.isRecording
    }
    
    //MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        #if DEBUG
        print("didFinishRecording")
        #endif
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
}
