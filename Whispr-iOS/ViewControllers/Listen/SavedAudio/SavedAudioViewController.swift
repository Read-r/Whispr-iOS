//
//  SavedAudioViewController.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-07-31.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import UIKit

class SavedAudioViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var datasource = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register("SavedAudioTableViewCell".nib, forCellReuseIdentifier: "AudioCell")
        
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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AudioSegue",
            let destVC = segue.destination as? PlayerViewController,
            let url = sender as? URL {
            destVC.urlToPlay = url 
        }
    }
}

extension SavedAudioViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell") as? SavedAudioTableViewCell else {
            return UITableViewCell()
        }
        
        let url = datasource[indexPath.row]
        
        cell.label.text = url.deletingPathExtension().lastPathComponent
        
        return cell
    }
}

extension SavedAudioViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "AudioSegue", sender: datasource[indexPath.row])
    }
}
