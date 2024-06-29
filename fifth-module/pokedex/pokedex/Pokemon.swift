//
//  Pokemon.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 21/06/24.
//

import Foundation

enum PokemonType: String, CaseIterable, Codable {
    case Normal = "Normal",
    Fire = "Fire",
    Water = "Water",
    Electric = "Electric",
    Grass = "Grass",
    Ice = "Ice",
    Fighting = "Fighting",
    Poison = "Poison",
    Ground = "Ground",
    Flying = "Flying",
    Psychic = "Psychic",
    Bug = "Bug",
    Rock = "Rock",
    Ghost = "Ghost",
    Dragon = "Dragon",
    Dark = "Dark",
    Steel = "Steel",
    Fairy = "Fairy"
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

struct Pokemon: Codable, Hashable {
    let id: Int
    let name: String
    let number: String
//    let type: [PokemonType]
    let type: [String]
    let imageURL: String
    let location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, type, location
        case number = "num"
        case imageURL = "img"
    }
    
    // implementing hashable
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    // implementing hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
