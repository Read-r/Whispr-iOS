//
//  TakenJobsViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-02.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class TakenJobsViewController: UIViewController {

    fileprivate var datasource = [Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job(), Job()]
    var tableview: UITableView {
        let jobsView = view as! JobsView
        
        return jobsView.tableView
    }
    
    override func loadView() {
        view = JobsView(frame: UIScreen.main.bounds)
        
        tableview.contentInset.top += UIApplication.shared.statusBarFrame.height
        
        if let tabbar = tabBarController?.tabBar {
            tableview.contentInset.bottom += tabbar.frame.size.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.contentInset = contentInsets()
        tableview.contentOffset = CGPoint(x: 0.0, y: -tableview.contentInset.top)
        
        tableview.register(SavedAudioTableViewCell.self, forCellReuseIdentifier: "JobCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let destVC = segue.destination as? RecordViewController,
            let obj = sender as? Job {
            destVC.job = obj
        }
    }
    
    
}

extension TakenJobsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as? SavedAudioTableViewCell else {
            return UITableViewCell()
        }
        
        let object = datasource[indexPath.row]
        
        cell.label.text = object.requester
        
        return cell
    }
}

extension TakenJobsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newVC = RecordViewController()
        newVC.job = datasource[indexPath.row]
        present(newVC, animated: true, completion: nil)
    }
}
