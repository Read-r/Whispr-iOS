//
//  PlayerViewController.swift
//  ReadMe
//
//  Created by Mikael Sundström on 2017-07-23.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioPlayerDelegate {

    var urlToPlay: URL? = nil
    
    var player : AVAudioPlayer? = nil
    lazy var updateTimer: Timer? = nil
    
    var progressBar: UISlider {
        guard let thisView = view as? PlayerView else {
            return UISlider()
        }
        
        return thisView.progressBar
    }
    
    private func timerFunc() -> Timer {
        return Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.progressBar.value = Float((self.player?.currentTime)!)
        })
    }

    override func loadView() {
        view = PlayerView(frame: UIScreen.main.bounds)
    }
    
    @IBAction func play(_ sender: Any) {
        
        guard let url = urlToPlay else {
            print("invalid URL")
            return
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
                                         with:.defaultToSpeaker)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
            return
        }
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.delegate = self
            
            if (self.player?.prepareToPlay())! {
                
                if (self.player?.play())! {
                    print("playing")
                    
                    if let timer = updateTimer {
                        timer.invalidate()
                        updateTimer = nil
                    }
                    
                    self.progressBar.value = 0.0
                    self.progressBar.minimumValue = 0.0
                    self.progressBar.maximumValue = Float((self.player?.duration)!)
                    
                    updateTimer = timerFunc()
                }
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    //MARK: AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
}
