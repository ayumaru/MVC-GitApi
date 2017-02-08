//
//  ViewController.swift
//  HomeWork-pepabo
//
//  Created by 西村歩夢 on 2017/01/28.
//  Copyright © 2017年 西村歩夢. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView! {
        didSet {
            let nib = UINib(nibName: "LoadCell", bundle: nil)
            table.register(nib, forCellReuseIdentifier: "LoadCell")
        }
    }
    
    let repositoryManager = RepositoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        download()
    }
    
    func download() {
        repositoryManager.download() { boo in
            if boo {
                self.table.reloadData()
            }
        }
    }

}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryManager.repositoryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if repositoryManager.shouldDownload(indexPath: indexPath) {
            download()
            let loadCell = tableView.dequeueReusableCell(withIdentifier: "LoadCell", for: indexPath)
            return loadCell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let repository = repositoryManager.item[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = "\(repository.star)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safari = SFSafariViewController(url: repositoryManager.item[indexPath.row].url)
        present(safari, animated: true, completion: nil)
    }
}

