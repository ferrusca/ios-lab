//
//  CustomTableViewController.swift
//  MusicBandsMVC
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import UIKit

class CustomTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public var sections: [Section]!;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
    }
}

extension CustomTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        }
        
        let rowData = sections[indexPath.section].rows[indexPath.row]
        var cellContent = cell?.defaultContentConfiguration()
        cellContent?.text = rowData.title
        cellContent?.secondaryText = rowData.subtitle
        
        print(rowData)
        if rowData.imagePath != "" {
            cellContent?.image = UIImage(named: rowData.imagePath)
        }
        
        
        cell?.contentConfiguration = cellContent;
        
        return cell!
        
    }
}

extension CustomTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].rows[indexPath.row].onRowClick()
    }
}
