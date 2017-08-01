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
    
    var audioRecorder : AVAudioRecorder? = nil
    private var fileURL : URL? = nil
    var fileName : String {
        set {
            let dirPaths = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask)
            
            fileURL = dirPaths[0].appendingPathComponent(newValue)
        }
        get {
            if let url = fileURL {
                return url.lastPathComponent
            }
            return ""
        }
    }
    
    override func setup() -> Bool {
        
        guard let url = fileURL else {
            return false
        }
        
        let settings =
            [AVFormatIDKey : kAudioFormatMPEG4AAC,
             AVNumberOfChannelsKey: 1,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        var recorder: AVAudioRecorder? = nil
        
        do {
            recorder = try AVAudioRecorder(url: url, settings:settings)
        }
        catch {
            print("error")
        }
        
        if let rec = recorder {
            rec.delegate = self
            audioRecorder = recorder
        }
    }
    
    override func record() -> Bool {
        
        guard setup(), let recorder = audioRecorder else {
            return false
        }
        
        if recorder.prepareToRecord() &&
           recorder.record() {
            #if DEBUG
                print("recording")
            #endif
            return true
        }
        
        return false
    }
    
    override func stopRecording() -> Bool {
        if self.audioRecorder.isRecording {
            self.audioRecorder.stop()
            self.audioRecorder = nil
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
