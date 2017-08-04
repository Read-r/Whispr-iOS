//
//  TakenJobsViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-02.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class TakenJobsViewController: UIViewController {

    fileprivate var datasource = [Job(), Job()]
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register("TakenJobTableViewCell".nib, forCellReuseIdentifier: "JobCell")
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as? TakenJobTableViewCell else {
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
        
        performSegue(withIdentifier: "Record", sender: datasource[indexPath.row])
    }
}
