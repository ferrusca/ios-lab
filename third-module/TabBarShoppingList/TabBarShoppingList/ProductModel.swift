//
//  ProductModel.swift
//  TabBarShoppingList
//
//  Created by Jorge Ferrusca on 30/05/24.
//

import Foundation

class ProductModel {
    private var products = ["Milk", "Eggs", "Meat", "Juice", "Lettuce", "Cheese", "Sausage", "Bread"]
    
    static var shared: ProductModel = {
       let instance = ProductModel()
        
        return instance
    }()
    
    
    // Private initializer to make this class a singleton (no one else can instantiate it)
    private init() {}
    
    public func addProduct(_ product: String) -> Void {
        self.products.insert(product, at: 0)
    }
    
    public func getProducts(filter searchText: String?) -> [String] {
        if let searchText {
            return products.filter {
                !$0.lowercased().ranges(of: searchText.lowercased()).isEmpty
            }
        }
        
        return products
    }
    
    public func getProductAt(index: Int) -> String {
        return products[index]
    }
}
