//
//  PizzaListModel.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import Foundation

class PizzaListViewModel {
    private var pizzas: [Pizza] = []
    private var toppings: [String] = []
    private let pizzaDataFileName = "pizza-info"
    private let pizzaDataFileExtension = "json"
    
    public var pizzasCount: Int { pizzas.count }
    public var toppingsCount: Int { toppings.count }
    public var cellIdentifier = "pizzaListCell"
    public var title = "Pizzas"
    
    init() {
        (pizzas, toppings) = loadData()
    }
    
    private func loadData() -> (pizzas: [Pizza], toppings: [String]) {
        guard let fileURL = Bundle.main.url(forResource: pizzaDataFileName,
                                            withExtension: pizzaDataFileExtension),
              let data = try? Data(contentsOf: fileURL),
              let pizzaDTO = try? JSONDecoder().decode(PizzaDTO.self, from: data)
        else {
            // stops here when in dev mode. In production this error is not thrown
            assertionFailure("Cannot read file \"\(pizzaDataFileName)\"")
            return (pizzas: [], toppings: [])
        }
        
        return (pizzas: pizzaDTO.pizzas, toppings: pizzaDTO.ingredients)
    }
    
    public func getPizza(at: IndexPath) -> Pizza {
        return pizzas[at.row]
    }
    
    public func getTopping(at: IndexPath) -> String {
        return toppings[at.row]
    }
}
