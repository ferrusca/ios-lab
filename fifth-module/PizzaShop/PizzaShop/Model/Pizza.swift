//
//  Pizza.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import Foundation

struct Pizza: Encodable, Decodable {
    let name: String
    var ingredients: [String]
}

struct PizzaDTO: Decodable {
    var pizzerias: [PizzaShop]
    var pizzas: [Pizza]
    var ingredients: [String]
}
