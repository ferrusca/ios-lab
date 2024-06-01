//
//  PokemonType.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import Foundation


struct PokemonTypeDamage {
    let name: String
    let imagePath: String
    let doubleDamageDealt: [PokemonType]
    let doubleDamageReceived: [PokemonType]
    let halfDamageDealt: [PokemonType]
    let halfDamageReceived: [PokemonType]
    let notAffectedBy: [PokemonType]
    let noAffectedAgainst: [PokemonType]
}


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


class PokemonTypeModel {
    private let pokemonTypeDamages: [PokemonTypeDamage] = [
        PokemonTypeDamage(
            name: PokemonType.Normal.rawValue,
            imagePath: "ghost.png",
            doubleDamageDealt: [],
            doubleDamageReceived: [.Fighting],
            halfDamageDealt: [.Rock, .Steel],
            halfDamageReceived: [],
            notAffectedBy: [.Ghost],
            noAffectedAgainst: [.Ghost]
        ),
        PokemonTypeDamage(
            name: PokemonType.Fire.rawValue,
            imagePath: "fire.png",
            doubleDamageDealt: [.Grass, .Ice, .Bug, .Steel],
            doubleDamageReceived: [.Water, .Ground, .Rock],
            halfDamageDealt: [.Fire, .Water, .Rock, .Dragon],
            halfDamageReceived: [.Fire, .Grass, .Ice, .Bug, .Steel, .Fairy],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Water.rawValue,
            imagePath: "water.png",
            doubleDamageDealt: [.Fire, .Ground, .Rock],
            doubleDamageReceived: [.Electric, .Grass],
            halfDamageDealt: [.Water, .Grass, .Dragon],
            halfDamageReceived: [.Fire, .Water, .Ice, .Steel],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Electric.rawValue,
            imagePath: "electric.png",
            doubleDamageDealt: [.Water, .Flying],
            doubleDamageReceived: [.Ground],
            halfDamageDealt: [.Electric, .Grass, .Dragon],
            halfDamageReceived: [.Electric, .Flying, .Steel],
            notAffectedBy: [],
            noAffectedAgainst: [.Ground]
        ),
        PokemonTypeDamage(
            name: PokemonType.Grass.rawValue,
            imagePath: "grass.png",
            doubleDamageDealt: [.Water, .Ground, .Rock],
            doubleDamageReceived: [.Fire, .Ice, .Poison, .Flying, .Bug],
            halfDamageDealt: [.Fire, .Grass, .Poison, .Flying, .Bug, .Dragon, .Steel],
            halfDamageReceived: [.Water, .Electric, .Grass, .Ground],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Ice.rawValue,
            imagePath: "ice.png",
            doubleDamageDealt: [.Grass, .Ground, .Flying, .Dragon],
            doubleDamageReceived: [.Fire, .Fighting, .Rock, .Steel],
            halfDamageDealt: [.Fire, .Water, .Ice, .Steel],
            halfDamageReceived: [.Ice],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Fighting.rawValue,
            imagePath: "fighting.png",
            doubleDamageDealt: [.Normal, .Ice, .Rock, .Dark, .Steel],
            doubleDamageReceived: [.Flying, .Psychic, .Fairy],
            halfDamageDealt: [.Poison, .Flying, .Psychic, .Bug, .Fairy],
            halfDamageReceived: [.Rock, .Bug, .Dark],
            notAffectedBy: [],
            noAffectedAgainst: [.Ghost]
        ),
        PokemonTypeDamage(
            name: PokemonType.Poison.rawValue,
            imagePath: "poison.png",
            doubleDamageDealt: [.Grass, .Fairy],
            doubleDamageReceived: [.Ground, .Psychic],
            halfDamageDealt: [.Poison, .Ground, .Rock, .Ghost],
            halfDamageReceived: [.Grass, .Fighting, .Poison, .Bug, .Fairy],
            notAffectedBy: [],
            noAffectedAgainst: [.Steel]
        ),
        PokemonTypeDamage(
            name: PokemonType.Ground.rawValue,
            imagePath: "ground.png",
            doubleDamageDealt: [.Fire, .Electric, .Poison, .Rock, .Steel],
            doubleDamageReceived: [.Water, .Grass, .Ice],
            halfDamageDealt: [.Grass, .Bug],
            halfDamageReceived: [.Poison, .Rock],
            notAffectedBy: [.Electric],
            noAffectedAgainst: [.Flying]
        ),
        PokemonTypeDamage(
            name: PokemonType.Flying.rawValue,
            imagePath: "flying.png",
            doubleDamageDealt: [.Grass, .Fighting, .Bug],
            doubleDamageReceived: [.Electric, .Ice, .Rock],
            halfDamageDealt: [.Electric, .Rock, .Steel],
            halfDamageReceived: [.Grass, .Fighting, .Bug],
            notAffectedBy: [.Ground],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Psychic.rawValue,
            imagePath: "psychic.png",
            doubleDamageDealt: [.Fighting, .Poison],
            doubleDamageReceived: [.Bug, .Ghost, .Dark],
            halfDamageDealt: [.Psychic, .Steel],
            halfDamageReceived: [.Fighting, .Psychic],
            notAffectedBy: [],
            noAffectedAgainst: [.Dark]
        ),
        PokemonTypeDamage(
            name: PokemonType.Bug.rawValue,
            imagePath: "bug.png",
            doubleDamageDealt: [.Grass, .Psychic, .Dark],
            doubleDamageReceived: [.Fire, .Flying, .Rock],
            halfDamageDealt: [.Fire, .Fighting, .Poison, .Flying, .Ghost, .Steel, .Fairy],
            halfDamageReceived: [.Grass, .Fighting, .Ground],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Rock.rawValue,
            imagePath: "rock.png",
            doubleDamageDealt: [.Fire, .Ice, .Flying, .Bug],
            doubleDamageReceived: [.Water, .Grass, .Fighting, .Ground, .Steel],
            halfDamageDealt: [.Fighting, .Ground, .Steel],
            halfDamageReceived: [.Normal, .Fire, .Poison, .Flying],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Ghost.rawValue,
            imagePath: "ghost.png",
            doubleDamageDealt: [.Psychic, .Ghost],
            doubleDamageReceived: [.Ghost, .Dark],
            halfDamageDealt: [.Dark],
            halfDamageReceived: [.Poison, .Bug],
            notAffectedBy: [.Normal, .Fighting],
            noAffectedAgainst: [.Normal]
        ),
        PokemonTypeDamage(
            name: PokemonType.Dragon.rawValue,
            imagePath: "dragon.png",
            doubleDamageDealt: [.Dragon],
            doubleDamageReceived: [.Ice, .Dragon, .Fairy],
            halfDamageDealt: [.Steel],
            halfDamageReceived: [.Fire, .Water, .Electric, .Grass],
            notAffectedBy: [],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Dark.rawValue,
            imagePath: "dark.png",
            doubleDamageDealt: [.Psychic, .Ghost],
            doubleDamageReceived: [.Fighting, .Bug, .Fairy],
            halfDamageDealt: [.Fighting, .Dark, .Fairy],
            halfDamageReceived: [.Ghost, .Dark],
            notAffectedBy: [.Psychic],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Steel.rawValue,
            imagePath: "steel.png",
            doubleDamageDealt: [.Ice, .Rock, .Fairy],
            doubleDamageReceived: [.Fire, .Fighting, .Ground],
            halfDamageDealt: [.Fire, .Water, .Electric, .Steel],
            halfDamageReceived: [.Normal, .Grass, .Ice, .Flying, .Psychic, .Bug, .Rock, .Dragon, .Steel, .Fairy],
            notAffectedBy: [.Poison],
            noAffectedAgainst: []
        ),
        PokemonTypeDamage(
            name: PokemonType.Fairy.rawValue,
            imagePath: "fairy.png",
            doubleDamageDealt: [.Fighting, .Dragon, .Dark],
            doubleDamageReceived: [.Poison, .Steel],
            halfDamageDealt: [.Fire, .Poison, .Steel],
            halfDamageReceived: [.Fighting, .Bug, .Dark],
            notAffectedBy: [.Dragon],
            noAffectedAgainst: []
        )
    ]
    
    public func getPokemonType(index: Int) -> PokemonTypeDamage {
        return pokemonTypeDamages[index]
    }
    
    private init() {}
}
