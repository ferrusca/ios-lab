//
//  PizzaShopListViewModel.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import Foundation

class PizzaShopListViewModel {
    private var shops: [PizzaShop] = []
    private let pizzaDataFileName = "pizza-info"
    private let pizzaDataFileExtension = "json"
    
    public var total: Int { shops.count }
    public var cellIdentifier = "pizzaShopListCell"
    public var title = "Pizza Shops"
    
    init() {
        shops = loadPizzaShops()
    }
    
    private func loadPizzaShops() -> [PizzaShop] {
        guard let fileURL = Bundle.main.url(forResource: pizzaDataFileName,
                                            withExtension: pizzaDataFileExtension),
              let data = try? Data(contentsOf: fileURL),
              let pizzaDTO = try? JSONDecoder().decode(PizzaDTO.self, from: data)
        else {
            // stops here when in dev mode. In production this error is not thrown
            assertionFailure("Cannot read file \"\(pizzaDataFileName)\"")
            return []
        }
        
        return pizzaDTO.pizzerias
    }
    
    public func getShop(at: IndexPath) -> PizzaShop {
        return shops[at.row]
    }
}
