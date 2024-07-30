//
//  CustomPizza.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 25/07/24.
//

import Foundation
import UIKit

class CustomPizzaListModel {
    private var pizzas: [Pizza] = []
    private var pizzasFileName = "myCustomPizzas"
    private var pizzasFileExtension = "json"
    public var total: Int { pizzas.count }
    public let cellIdentifier = "customPizzaCell"
    
    init() {
        print("Instanciating CustomPizzaListModel by first time")
        self.pizzas = loadPizzas()
        
        // Saving data from custom pizzas when app is going inactive
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeCustomPizzas),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    private func loadPizzas() -> [Pizza] {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first
        else {
            assertionFailure("Cannot find the documents directory")
            return []
        }

        let fileURL = documentsDirectoryURL.appendingPathComponent("myCustomPizzas.json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            return try JSONDecoder().decode([Pizza].self, from: data)
        } catch {
            return []
        }
    }
    
    @objc private func storeCustomPizzas() {
        print("App is going inactive. Storing custom pizzas...")
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else { return }
        
        let fileURL = documentsDirectory.appending(
            component: "\(pizzasFileName).\(pizzasFileExtension)"
        )
        let customPizzas = Array(pizzas)
        
        do {
            let favoritePokemonData = try JSONEncoder().encode(customPizzas)
            let jsonPizzas = String(data: favoritePokemonData, encoding: .utf8)
            
            try jsonPizzas?.write(to: fileURL,
                                  atomically: true,
                                  encoding: .utf8)
        } catch {
            assertionFailure("Failed storing custom pizzas")
        }
    }
    
    public func addPizza(pizza: Pizza) {
        self.pizzas.append(pizza)
    }
    
    public func removePizza(_ deletePizza: Pizza) {
        self.pizzas = self.pizzas.filter { pizza in
            pizza.name != deletePizza.name
        }
    }
    
    public func removePizza(at: IndexPath) {
        self.pizzas.remove(at: at.row)
    }
    
    public func getPizza(at: IndexPath) -> Pizza {
        return self.pizzas[at.row]
    }
    
    
    public func getAll() -> [Pizza] {
        return self.pizzas
    }
}
