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

    var player : AVAudioPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback, with:.defaultToSpeaker)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(_ sender: Any) {
        
        let dirPaths = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.m4a")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: soundFileURL)
            self.player?.delegate = self
            
            if (self.player?.prepareToPlay())! {
                
                if (self.player?.play())! {
                    print("playing")
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
