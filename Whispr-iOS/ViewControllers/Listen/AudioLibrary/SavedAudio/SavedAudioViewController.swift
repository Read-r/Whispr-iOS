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
    
    var showingFilters : Bool = false
    var datasource = [URL]()
    var filterView : FilterViewController? = nil
    
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
    @IBAction func filterAction(_ sender: Any) {
        showingFilters = !showingFilters
        
        DispatchQueue.main.async {
            if self.showingFilters {
                self.filterView = FilterViewController(["options1", "option2", "options3"])
                //self.filterView?.view.alpha = 0.0
                
                self.filterView?.view.frame.origin = CGPoint(x:0, y:20+(self.navigationController?.navigationBar.bounds.height)!-(self.filterView?.view.bounds.height)!)
            }
            
            UIView.animate(withDuration: 0.25, animations: {
                if self.showingFilters {
                    guard self.filterView != nil else {
                        return
                    }
                    
                    self.view?.addSubview((self.filterView?.view)!)
                    
                    self.tableView.contentInset.top += (self.filterView?.view.bounds.height)!
                    
                    if self.tableView.contentOffset.y < 10 {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    
                    self.filterView?.view.frame.origin = CGPoint(x:0, y:20+(self.navigationController?.navigationBar.bounds.height)!)
                    //self.filterView?.view.alpha = 1.0
                    
                    
//                    if !UIAccessibilityIsReduceTransparencyEnabled() {
//                        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//                        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//                        //always fill the view
//                        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                        blurEffectView.frame = (self.filterView?.view.bounds)!
//                        
//                        self.filterView?.view.insertSubview(blurEffectView, at: 0)
//                    } else {
//                        self.filterView?.view.backgroundColor = UIColor.black
//                    }
                }
                else {
                    self.tableView.contentInset.top -= (self.filterView?.view.bounds.height)!
                    
                    //self.filterView?.view.alpha = 0.0
                    self.filterView?.view.frame.origin.y -= (self.filterView?.view.bounds.height)!
                }
            }, completion: { (completion) in
                if !self.showingFilters {
                    self.filterView?.view.removeFromSuperview()
                    self.filterView = nil
                }
            })
        }
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
        
        //let url = datasource[indexPath.row]
        
        //cell.label.text = url.deletingPathExtension().lastPathComponent
        
        cell.label.text = "cell" + String(describing:indexPath.row)
        
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
