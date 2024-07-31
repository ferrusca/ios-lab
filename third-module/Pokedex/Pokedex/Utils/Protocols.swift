//
//  Protocols.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/07/24.
//

import UIKit

//protocol PokemonDetailModelDelegate where Self: UIViewController {
protocol PokemonDetailModelDelegate: AnyObject {
    func getPokemonChainFrom(endpoint: EndpointProtocol)
}
