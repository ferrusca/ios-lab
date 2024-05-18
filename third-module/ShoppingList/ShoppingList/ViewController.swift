//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import UIKit

class ViewController: UIViewController {
    var items = ["VW", "Volvo", "Acura", "Chevrolet"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func addTapped(_ sender: UIButton) -> Void {
        guard let text = textField.text else {
            items.append("Empty value????")
            tableView.reloadData()
            return
        }
        items.append(text == "" ? "Empty string!" : text)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Car Makers"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        }
        
        var cellContent = cell?.defaultContentConfiguration()
        cellContent?.text = items[indexPath.row]
        cell?.contentConfiguration = cellContent;

        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, complete in

            let alertController = UIAlertController(title: "Delete the following element?", message: self.items[indexPath.row], preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Yes, delete", style: .destructive) { _ in
                self.items.remove(at: indexPath.row)
                tableView.reloadData()
            }
            let dismissAction = UIAlertAction(title: "No", style: .cancel) {
                _ in
                tableView.setEditing(false, animated: true)

            }
            alertController.addAction(deleteAction)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true)

        }

        delete.image = UIImage(systemName: "trash.fill")

        delete.image?.withTintColor(.white)

        delete.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        
        
        
    }
            
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete The following element?", message: items[indexPath.row], preferredStyle: .alert)
            
        let deleteAction = UIAlertAction(title: "Yes, delete", style: .destructive) { _ in
            print("Alert controller dismissed")
        }
        let dismissAction = UIAlertAction(title: "No", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}

