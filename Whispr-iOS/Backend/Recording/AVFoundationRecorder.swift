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
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with:.defaultToSpeaker)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    override func record() -> Bool {
        
        guard setup(), let recorder = audioRecorder else {
            return false
        }
        
        guard recorder.prepareToRecord() else {
            #if DEBUG
                print("prepareToRecord failed!")
            #endif
            
            return false
        }
        
        if recorder.record() {
            #if DEBUG
                print("recording")
            #endif
            return true
        }
        else {
            #if DEBUG
                print("record faileds")
            #endif
        }
        
        return false
    }
    
    override func stopRecording() -> Bool {
        
        guard let recorder = audioRecorder else {
            return false
        }
        
        if recorder.isRecording {
            recorder.stop()
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
        guard let recorder = audioRecorder else {
            return false
        }
        
        return recorder.isRecording
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
