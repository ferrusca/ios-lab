//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let image: String
    let number: Int
    let pokedexInfo: String
    let types: [PokemonType]
    let evolutionChain: [String]
}

class PokemonModel {
    var favorites: [Pokemon] = {
        if let savedData = UserDefaults.standard.data(forKey: "favoritePokemons"),
           let decodedArray = try? JSONDecoder().decode([Pokemon].self, from: savedData) {
            print(decodedArray[0])
            return decodedArray
        } else {
            // No data yet, initializing with empty string
            return []
        }
    }()
    
    
    private var pokemons: [Pokemon] = [
        Pokemon(
            name: "Bulbasaur",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            number: 1,
            pokedexInfo: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
            types: [.Grass, .Poison],
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
        ),
        Pokemon(
            name: "Ivysaur",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png",
            number: 2,
            pokedexInfo: "When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.",
            types: [.Grass, .Poison],
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
        ),
        Pokemon(
            name: "Venusaur",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png",
            number: 3,
            pokedexInfo: "The plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.",
            types: [.Grass, .Poison],
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
       ),
        Pokemon(
            name: "Charmander",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
            number: 4,
            pokedexInfo: "Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.",
            types: [.Fire],
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        ),
        Pokemon(
            name: "Charmeleon",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png",
            number: 5,
            pokedexInfo: "When it swings its burning tail, it elevates the temperature to unbearably high levels.",
            types: [.Fire],
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        ),
        Pokemon(
            name: "Charizard",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png",
            number: 6,
            pokedexInfo: "Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally.",
            types: [.Fire, .Flying],
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        ),
        Pokemon(
            name: "Squirtle",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
            number: 7,
            pokedexInfo: "After birth, its back swells and hardens into a shell. Powerfully sprays foam from its mouth.",
            types: [],
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
        ),
        Pokemon(
            name: "Wartortle",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png",
            number: 8,
            pokedexInfo: "Often hides in water to stalk unwary prey. For swimming fast, it moves its ears to maintain balance.",
            types: [.Water],
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
        ),
        Pokemon(
            name: "Blastoise",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png",
            number: 9,
            pokedexInfo: "A brutal Pokémon with pressurized water jets on its shell. They are used for high-speed tackles.",
            types: [.Water],
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
       ),
        Pokemon(
            name: "Caterpie",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png",
            number: 10,
            pokedexInfo: "Its short feet are tipped with suction pads that enable it to tirelessly climb slopes and walls.",
            types: [.Bug],
            evolutionChain: ["Caterpie", "Metapod", "Butterfree"]
        )
    ];
    
    public func getFavorites() -> [Pokemon] {
        return favorites
    }
    
    public func addToFavorites(pokemon: Pokemon) {
        favorites.append(pokemon)
        storeEncodedData(favorites, key: "favoritePokemons")
    }
    
    public func removeFromFavorites(pokemon: Pokemon) {
        guard let index = favorites.firstIndex(where: { favorite in favorite.name == pokemon.name }) else {
            fatalError("INDEX NOT FOUND")
        }
        
        favorites.remove(at: index)
        storeEncodedData(favorites, key: "favoritePokemons")
    }
    
    private func storeEncodedData<T>(_ data: T, key: String) -> Void where T : Encodable {
        if let encodedData = try? JSONEncoder().encode(data) {
            // Guardar el JSON codificado en UserDefaults con una clave específica
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
        
    private init () {}
}

