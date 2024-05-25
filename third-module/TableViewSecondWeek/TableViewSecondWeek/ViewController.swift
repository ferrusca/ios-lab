//
//  ViewController.swift
//  TableViewSecondWeek
//
//  Created by Jorge Ferrusca on 24/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func toggleEditTable() {
        tableView.isEditing = !tableView.isEditing
        
    }
    
    var countries = ["Ukraine", "Italy", "Argentina", "Spain", "Indonesia"]
    var results = [String]()
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        // initializing results array
        results = countries;
    }
    


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    // whether or not to allow to reorder a row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // after row is being ordered
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        countries.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        }
        
        var cellContent = cell?.defaultContentConfiguration()
        cellContent?.text = results[indexPath.row]
        cellContent?.secondaryText = "subtitle"
        cell?.contentConfiguration = cellContent
        
        return cell!
    }
}

// Delegating SearchBar
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let regex = NSRegularExpression(".*[\(searchText)].*")

        isSearching = true
        
        results = countries.filter {
            print($0.lowercased().ranges(of: searchText.lowercased()))
            return !$0.lowercased().ranges(of: searchText.lowercased()).isEmpty
            
        }
        
        print(results)
        
        tableView.reloadData()
    }
}

