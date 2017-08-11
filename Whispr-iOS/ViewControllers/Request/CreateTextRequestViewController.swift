//
//  CreateTextRequestViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class CreateTextRequestViewController: UIViewController {
    
    private var newJob = Job()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestOptions",
            let destVC = segue.destination as? RequestOptionsViewController {
            destVC.newJob = newJob
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        guard let baseVC = presentingViewController else {
            return
        }
        
        baseVC.dismiss(animated: true)
    }
}

extension CreateTextRequestViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        nextButton.isEnabled = textView.text != ""
    }
}
