//
//  ViewController.swift
//  MyFirstTable
//
//  Created by Jorge Ferrusca on 17/05/24.
//

import UIKit

class ViewController: UIViewController {
    var weekDays = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"]
    let weekend = ["Saturday", "Sunday"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func addButton(_ sender: UIButton) {
        print(textField.text)
        weekDays.append(textField.text ?? "Empty value")
        
        // refreshing data in the table view
        tableView.reloadData()
    }
    
    
//    Need to setup these things for a table:
//    1. Cell
//    2. dataSource
//    3. Delegated

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating the table datasource
        tableView.dataSource = self
        
        // attaching the delegate
        tableView.delegate = self
        
        // registering custom cell
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

}


// Conforming DataSource protocol
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "My first table"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0  {
            return weekDays.count
        }
        
        return weekend.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // obtaining my custom cell
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        let title = indexPath.section == 0 ? weekend[indexPath.row] : weekDays[indexPath.row]
        customCell.cellTextLabel.text = title
        
        return customCell
    }
    
    func tableViewWithNoCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: Not reusable cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "This is subtitle"
    
        // MARK: reusable cell
        // Adding current existing cell
        var cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2")
        
        if cell2 != nil {
            // Cell already exists
            return cell2!
        }
        

        
        print("Creating cell")
        // Creating cell if doesn't exist
        cell2 = UITableViewCell(style: .subtitle, reuseIdentifier: "cell2")
        cell2?.textLabel?.text = "Hola"
        cell2?.backgroundColor = .purple
        cell2?.accessoryType = .disclosureIndicator
        
        
        let title = indexPath.section == 0 ? weekend[indexPath.row] : weekDays[indexPath.row]
        
        if #unavailable(iOS 14) {
            // cell Content config not available in < ios14
            
            cell2?.textLabel?.text = title
        } else {
            var cellContent = cell2?.defaultContentConfiguration()
            cellContent?.text = title
            cellContent?.secondaryText = "this is the subtitle"
            
            cell2?.contentConfiguration = cellContent;
        }
        
        return cell2!
    }
    
    
}



extension ViewController: UITableViewDelegate {
    // set the row's height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70.0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
