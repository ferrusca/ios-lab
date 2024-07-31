//
//  EvolutionChainModel.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/07/24.
//

import Foundation

struct Species: Decodable {
    let name: String
    let url: String
}

struct InnerEvolvesTo: Decodable {
    let species: Species
}

struct EvolvesTo: Decodable {
    let evolvesTo: [InnerEvolvesTo]
    let species: Species
    
    private enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }
}

struct Chain: Decodable {
    let evolvesTo: [EvolvesTo]
    let species: Species
    
    private enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }
}

struct EvolutionChainDTO: Decodable {
    let chain: Chain
}
