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
    
    var textView: UITextView  {
        let requestView = view as! CreateTextRequestView
        
        return requestView.textView
    }
    
    var nextButton: UIBarButtonItem {
        let requestView = view as! CreateTextRequestView
        
        return requestView.nextBarButton
    }
    
    var cancelButton: UIBarButtonItem {
        let requestView = view as! CreateTextRequestView
        
        return requestView.cancelBarButton
    }
    
    override func loadView() {
        view = CreateTextRequestView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        cancelButton.target = self
        cancelButton.action = #selector(cancelAction(_:))
        
        nextButton.target = self
        nextButton.action = #selector(nextAction(_:))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func cancelAction(_ sender: Any) {
        guard let baseVC = presentingViewController else {
            return
        }
        
        baseVC.dismiss(animated: true)
    }
    
    @objc func nextAction(_ sender: Any) {
        let options = RequestOptionsViewController(withJob:newJob)
        
        if let navController = navigationController {
            navController.pushViewController(options, animated: true)
        }
    }
}

extension CreateTextRequestViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        nextButton.isEnabled = textView.text != ""
    }
}
