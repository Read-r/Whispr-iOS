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
    
    var job: Job? = nil
    
    var recorder : Recorder = AVFoundationRecorder()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func buttonAction(_ sender: Any) {
        if self.recorder.isRecording() {
            stopRecording()
        }
        else {
            
            nameFile({ (name) in
                self.recorder.fileName = name
                
                self.recorder.record()
                self.recordButton.titleLabel?.text = "Stop recording"
                self.recordButton.sizeToFit()
            })
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        cancelRecording()
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func cancelRecording() {
        stopRecording()
        
        guard let url = recorder.fileURL else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: url)
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
    
    private func stopRecording() {
        recorder.stopRecording()
        recordButton.titleLabel?.text = "Record"
        recordButton.sizeToFit()
    }
    
    private func nameFile(_ onNamed:@escaping (_ name:String) -> Void) {
        let alertController = UIAlertController(title: "NameFile", message: "Give the file a name", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            guard   let textField = alertController.textFields?[0],
                    let fileName = textField.text else {
                return
            }
            
            onNamed(fileName + ".m4a")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = job?.text ?? ""
    }
}
