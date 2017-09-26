//
//  SavedAudioViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-07-31.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class SavedAudioViewController: UIViewController {

    var tableView: UITableView {
        let theView = view as! SavedAudioView
        
        return theView.tableview
    }
    
    var showingFilters : Bool = false
    var datasource = [URL]()
    
    override func loadView() {
        view = SavedAudioView(frame: UIScreen.main.bounds)
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = {() -> CGFloat in
            if let navBar = self.navigationController?.navigationBar {
                return navBar.frame.height
            }
            return 0.0
        }()
        
        let tabBarHeight = {() -> CGFloat in
            if let tabBar = self.tabBarController?.tabBar {
                return tabBar.frame.height
            }
            return 0.0
        }()
        
        tableView.contentInset.top = statusBarHeight + navigationBarHeight
        tableView.contentInset.bottom = tabBarHeight
        
        tableView.contentOffset = CGPoint(x: 0.0, y: -tableView.contentInset.top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SavedAudioTableViewCell.self, forCellReuseIdentifier: "AudioCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: Recorder.baseURL, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            datasource.append(contentsOf: directoryContents.filter{ $0.pathExtension == "m4a" })
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterAction(_:)))
        navigationItem.rightBarButtonItem = filterButton
        
        //filterAction(sender:self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AudioSegue",
            let destVC = segue.destination as? PlayerViewController,
            let url = sender as? URL {
            destVC.urlToPlay = url 
        }
    }
    
    @objc func filterAction(_ sender: Any) {
        guard let theView = view as? SavedAudioView else {
            assertionFailure()
            return
        }
        
        showingFilters = !showingFilters
        
        theView.filterToggle(showFilter: showingFilters)
    }
}

extension SavedAudioViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30//datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell") as? SavedAudioTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.row < datasource.count {
            cell.label.text = datasource[indexPath.row].deletingPathExtension().lastPathComponent
        }
        else {
            cell.label.text = "cell" + String(describing:indexPath.row)
        }
        
        return cell
    }
}

extension SavedAudioViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newController = PlayerViewController()
        
        self.navigationController?.pushViewController(newController, animated: true)
    }
}

extension SavedAudioViewController: FilterViewDelegate {
    func didToggleFilter(withName name: String, toState state: Bool) {
        print(name + " -> \(state)")
    }
}
