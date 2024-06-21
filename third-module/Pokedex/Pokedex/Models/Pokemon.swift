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
    let number: String
    let pokedexInfo: String
    let types: [PokemonType]
    let evolutionChain: [String]
}

struct PokemonResponse: Decodable {
    let results: [PokemonDTO]
}

struct PokemonDTO: Decodable {
    let name: String
    let url: String
    
//    // map from original to new key values
//    private enum CodingKeys: String, CodingKey {
//        case name
//        case detailsURL = "url"
//    }
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
    
    public func getAllFromAPI(foo: Int, completitionHandler: @escaping (Error?) -> Void) {
        RequestHandler().get(buildEndpoint()) { (result: Result<PokemonResponse, Error>) in
            print("result")
                    switch result {
                    case .success(let pokemonDTOs):
                        print(pokemonDTOs)
                        self.pokemons = pokemonDTOs.results.enumerated().map { (index, pokemonDTO) in
                            Pokemon(name: pokemonDTO.name, image: "", number: "\(index + 1)", pokedexInfo: "", types: [], evolutionChain: [])
                        }
                        // no errors
                        completitionHandler(nil)
                    case .failure(let failure):
                        print(failure)
                        completitionHandler(failure)
                    }
                    
                }
    }
    
    func buildEndpoint() -> EndpointProtocol {
        let queries = [
            URLQueryItem(name: "limit", value: "100000"),
            URLQueryItem(name: "offset", value: "0")
        ]
        
        return UserBaseEndpoint(path: "/pokemon", queries: queries)
    }
    
    private var pokemons: [Pokemon] = [
        Pokemon(
            name: "Bulbasaur",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            number: "001",
            pokedexInfo: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
            types: [.Grass, .Poison],
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
        ),
        Pokemon(
            name: "Ivysaur",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png",
            number: "002",
            pokedexInfo: "When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.",
            types: [.Grass, .Poison],
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
        ),
        Pokemon(
            name: "Venusaur",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png",
            number: "003",
            pokedexInfo: "The plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.",
            types: [.Grass, .Poison],
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
       ),
        Pokemon(
            name: "Charmander",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
            number: "004",
            pokedexInfo: "Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.",
            types: [.Fire],
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        ),
        Pokemon(
            name: "Charmeleon",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png",
            number: "005",
            pokedexInfo: "When it swings its burning tail, it elevates the temperature to unbearably high levels.",
            types: [.Fire],
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        ),
        Pokemon(
            name: "Charizard",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png",
            number: "006",
            pokedexInfo: "Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally.",
            types: [.Fire, .Flying],
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        ),
        Pokemon(
            name: "Squirtle",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
            number: "007",
            pokedexInfo: "After birth, its back swells and hardens into a shell. Powerfully sprays foam from its mouth.",
            types: [],
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
        ),
        Pokemon(
            name: "Wartortle",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png",
            number: "008",
            pokedexInfo: "Often hides in water to stalk unwary prey. For swimming fast, it moves its ears to maintain balance.",
            types: [.Water],
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
        ),
        Pokemon(
            name: "Blastoise",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png",
            number: "009",
            pokedexInfo: "A brutal Pokémon with pressurized water jets on its shell. They are used for high-speed tackles.",
            types: [.Water],
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
       ),
        Pokemon(
            name: "Caterpie",
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png",
            number: "010",
            pokedexInfo: "Its short feet are tipped with suction pads that enable it to tirelessly climb slopes and walls.",
            types: [.Bug],
            evolutionChain: ["Caterpie", "Metapod", "Butterfree"]
        )
    ];
    
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
    
    public func getPokemonEvolutionChainDetail(_ originalPokemon: Pokemon) -> [Pokemon] {
        guard let currentPokemonIndexInChain = originalPokemon.evolutionChain.firstIndex(of: originalPokemon.name) else {
            return []
        }
        

//        if currentPokemonIndexInChain == originalPokemon.evolutionChain.count - 1 {
//            // Current pokemon is the last in the chain
//            return []
//        }
        
        
//        let pokemonNamesChainFiltered = originalPokemon.evolutionChain[(currentPokemonIndexInChain + 1)...]
        let pokemonNamesChainFiltered = originalPokemon.evolutionChain
        var nextPokemons = [Pokemon]()
        

        print(pokemonNamesChainFiltered)
        
        for pokemonName in pokemonNamesChainFiltered {
            print(pokemonName)
            if let nextPokemon = pokemons.first(where: { pokemon in
                pokemon.name == pokemonName
            }) {
                nextPokemons.append(nextPokemon)
            }
        }
        
        return nextPokemons
    }
    
    public func getPokemons(searchText: String) -> [Pokemon] {
        return pokemons.filter({ pokemon in
            !pokemon.name.lowercased().ranges(of: searchText.lowercased()).isEmpty
        })
    }
    
    public func getFavorites(searchText: String) -> [Pokemon] {
        return favorites.filter({ pokemon in
            !pokemon.name.lowercased().ranges(of: searchText.lowercased()).isEmpty
        })
    }
    
    public func isFavorite(pokemon: Pokemon) -> Bool {
        let favorite = favorites.first(where: { favorite in
            favorite.name == pokemon.name
        })
        
        return favorite != nil
    }
    
    private func storeEncodedData<T>(_ data: T, key: String) -> Void where T : Encodable {
        if let encodedData = try? JSONEncoder().encode(data) {
            // Guardar el JSON codificado en UserDefaults con una clave específica
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
        
    static var standard: PokemonModel = {
       let instance = PokemonModel()
        
        return instance
    }()

    private init () {}
}

