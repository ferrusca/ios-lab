//
//  PizzaShop.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import Foundation

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct PizzaShop: Decodable {
    let name: String
    let address: String
    let coordinates: Coordinates?
}
