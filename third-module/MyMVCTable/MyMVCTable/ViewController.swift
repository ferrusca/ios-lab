//
//  ViewController.swift
//  MyMVCTable
//
//  Created by Jorge Ferrusca on 17/05/24.
//

import UIKit

class ViewController: UIViewController {
    let model = TableViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getCountArray()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        }
        
        cell?.textLabel?.text = model.getTitle(indexPath)
        cell?.detailTextLabel?.text = model.getDescription(indexPath)
        
        return cell!
    }
}

