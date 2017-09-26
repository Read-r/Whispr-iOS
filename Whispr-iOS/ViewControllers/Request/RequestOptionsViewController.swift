//
//  RequestOptionsViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class RequestOptionsViewController: UIViewController {
    
    var tableView: UITableView {
        let optionsView = view as! RequestOptionsView
        
        return optionsView.tableView
    }
    
    var newJob : Job? = nil {
        didSet {
            guard let job = newJob else {
                return
            }
            pickedDate = job.dueDate
        }
    }
    
    fileprivate var pickedUser : User? = nil
    fileprivate var pickedDate = Date()
    fileprivate var datePickerExpanded = false
    
    fileprivate var datePicker : UIDatePicker? = nil
    fileprivate var dateLabel : UILabel? = nil
    
    init(withJob job: Job?) {
        super.init(nibName: nil, bundle: nil)
        
        newJob = job
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = RequestOptionsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PickUserTableViewCell.self, forCellReuseIdentifier: "PickUser")
        tableView.register(SavedAudioTableViewCell.self, forCellReuseIdentifier: "Date")
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: "DatePicker")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    @IBAction func createRequestAction(_ sender: Any) {
        guard let presentingVC = presentingViewController else {
            return
        }
        
        NotificationController.displayNotification("Request sent!", position: .top)
        
        presentingVC.dismiss(animated: true, completion: nil)
    }
}

extension RequestOptionsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return datePickerExpanded ? 2 : 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row, indexPath.section) {
        case (0, 0):
            guard   let cell = tableView.dequeueReusableCell(withIdentifier: "PickUser", for: indexPath) as? PickUserTableViewCell,
                    let job = newJob else {
                return UITableViewCell()
            }
            
            cell.configure(withUser: job.requestedReder)
            
            return cell
        case (0, 1):
            guard   let cell = tableView.dequeueReusableCell(withIdentifier: "Date", for: indexPath) as? SavedAudioTableViewCell,
                    let job = newJob else {
                return UITableViewCell()
            }
            
            cell.label.text = job.dueDate.asString("yyyy-MM-dd")
            
            return cell
        case (1, 1):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DatePicker", for: indexPath) as? DatePickerTableViewCell else {
                return UITableViewCell()
            }
            
            datePicker = cell.datePicker
            if let picker = datePicker {
                picker.datePickerMode = .date
                picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc private func dateChanged() {
        if  let picker = datePicker,
            let job = newJob {
            job.dueDate = picker.date
            
            tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        }
    }
}

extension RequestOptionsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.row, indexPath.section) {
        case (0, 0):
            return 60.0
        case (1, 1):
            return 170
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row, indexPath.section) == (0, 0) {
            let userPickVC = BrowseUsersViewController(nibName: nil, bundle: nil)
            userPickVC.delegate = self
            let navController = UINavigationController(rootViewController: userPickVC)
            
            present(navController, animated: true, completion: nil)
        }
        else if (indexPath.row, indexPath.section) == (0, 1) {
            tableView.beginUpdates()
            
            if datePickerExpanded {
                tableView.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
            }
            else {
                tableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
            }
            
            datePickerExpanded = !datePickerExpanded
            
            tableView.endUpdates()
        }
    }
}

extension RequestOptionsViewController : UserBrowseAndPickDelegate {
    func userPicked(_ user: User) {
        guard let job = newJob else {
            return
        }
        
        job.requestedReder = user
        
        tableView.reloadData()
    }
}
