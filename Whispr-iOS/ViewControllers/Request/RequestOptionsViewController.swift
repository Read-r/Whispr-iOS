//
//  RequestOptionsViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-07.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class RequestOptionsViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var newJob : Job? = nil
    
    fileprivate var pickedUser : User? = nil
    fileprivate var pickedDate = Date()
    fileprivate var datePickerExpanded = false
    
    fileprivate var datePicker : UIDatePicker? = nil
    fileprivate var dateLabel : UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register("PickUserTableViewCell".nib, forCellReuseIdentifier: "PickUser")
        tableview.register("DateTableViewCell".nib, forCellReuseIdentifier: "Date")
        tableview.register("DatePickerTableViewCell".nib, forCellReuseIdentifier: "DatePicker")
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BrowseUsers",
            let baseDestVC = segue.destination as? UINavigationController {
            
            guard let destVC = baseDestVC.topViewController as? BrowseUsersViewController else {
                return
            }
            
            destVC.delegate = self
        }
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
            guard   let cell = tableview.dequeueReusableCell(withIdentifier: "PickUser", for: indexPath) as? PickUserTableViewCell,
                    let job = newJob else {
                return UITableViewCell()
            }
            
            cell.configure(withUser: job.requestedReder)
            
            return cell
        case (0, 1):
            guard   let cell = tableview.dequeueReusableCell(withIdentifier: "Date", for: indexPath) as? DateTableViewCell,
                    let job = newJob else {
                return UITableViewCell()
            }
            
            cell.label.text = job.dueDate.asString("yyyy-MM-dd")
            
            return cell
        case (1, 1):
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "DatePicker", for: indexPath) as? DatePickerTableViewCell else {
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
            
            tableview.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
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
        tableview.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row, indexPath.section) == (0, 0) {
            performSegue(withIdentifier: "BrowseUsers", sender: nil)
        }
        else if (indexPath.row, indexPath.section) == (0, 1) {
            tableview.beginUpdates()
            
            if datePickerExpanded {
                tableview.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
            }
            else {
                tableview.insertRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
            }
            
            datePickerExpanded = !datePickerExpanded
            
            tableview.endUpdates()
        }
    }
}

extension RequestOptionsViewController : UserBrowseAndPickDelegate {
    func userPicked(_ user: User) {
        guard let job = newJob else {
            return
        }
        
        job.requestedReder = user
        
        tableview.reloadData()
    }
}
