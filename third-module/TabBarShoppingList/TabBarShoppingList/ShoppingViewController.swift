//
//  ShoppingViewController.swift
//  TabBarShoppingList
//
//  Created by Jorge Ferrusca on 30/05/24.
//

import UIKit

class ShoppingViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shoppingCartLabel: UILabel!
    
    // List of filtered products to display in the search list
    var results = [String]()
    var cart: [String] = []
    let productModel = ProductModel.shared
    
    private func addProductToCart(name: String) {
        cart.insert(name, at: 0)
        collectionView.reloadData()
        updateCartLabel()
    }
    
    
    private func updateCartLabel() {
        self.shoppingCartLabel.text = cart.count < 1 ? "Shopping Cart" : "Shopping Cart (Items: \(cart.count))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        // set collection view cell height
        collectionView.delegate = self
        // register custom collection cell
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    
    // Reload table view with the latest data
    override func viewWillAppear(_ animated: Bool) {
        results = productModel.getProducts(filter: nil)
        searchBar.text = ""
        tableView.reloadData()
    }
}

extension ShoppingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        results = productModel.getProducts(filter: searchText)
        
        tableView.reloadData()
    }
}

extension ShoppingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") 
            ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = results[indexPath.row]
//        cellContent.imageProperties
        
        cell.contentConfiguration = cellContent
        
        return cell
    }
}

// Table view height and row click handler
extension ShoppingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addProductToCart(name: results[indexPath.row])
    }
}

extension ShoppingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath)) as! ItemCollectionViewCell
        
        cell.setup(productName: cart[indexPath.row])
        
        return cell
    }
}

extension ShoppingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 120)
    }
}

// Collection view cell click handler
extension ShoppingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let removeAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.cart.remove(at: indexPath.row)
            collectionView.reloadData()
            self.updateCartLabel()
        }
        let alert = UIAlertController(title: "Do you want to remove \(cart[indexPath.row]) from cart?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(removeAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
        
    }
}
