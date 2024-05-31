//
//  ProductsViewController.swift
//  TabBarShoppingList
//
//  Created by Jorge Ferrusca on 30/05/24.
//

import UIKit

class ProductsViewController: UIViewController {
    let productModel = ProductModel.shared
    
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func characterTyped(sender: UITextField) {
        addButton.isEnabled = sender.text != nil && sender.text?.isEmpty == false
    }
    
    @IBAction func addProduct(sender: UIButton) {
        productModel.addProduct(productTextField.text ?? "")
        print(productModel.getProducts(filter: nil))
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.isEnabled = false
        // delegating table view
        tableView.dataSource = self
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModel.getProducts(filter: nil).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        let product = productModel.getProductAt(index: indexPath.row)
        cellContent.text = product
        cellContent.image = UIImage(systemName: "\(product.first?.lowercased() ?? "questionmark").square.fill")
        cell.contentConfiguration = cellContent;
        
        return cell
    }
}
