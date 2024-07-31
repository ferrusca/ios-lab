//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let image: String
    let number: String
    // NOTE: this prop is unused since the info is placed directly in the UI label
//    let pokedexInfo: String
    let types: [PokemonType]
    // NOTE: this prop is setted when opening "pokemon detail" view
    var evolutionChain: [String]
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

class PokemonListModel {
    var pokemons: [Pokemon] = []
    
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
    
    public func getAllFromAPI(completitionHandler: @escaping (Error?) -> Void) {
        RequestHandler().get(buildEndpoint()) { (result: Result<PokemonResponse, Error>) in
            print("getAll was successful")
                    switch result {
                    case .success(let pokemonDTOs):
                        self.pokemons = pokemonDTOs.results.enumerated().map { (index, pokemonDTO) in
                            let pokemonNumber = index < 100
                                // prepending zeros if needed
                                ? String("00\(index + 1)".suffix(3))
                                : "\(index + 1)"
                            
                            return Pokemon(id: index + 1,
                                           name: pokemonDTO.name,
                                           image: "https://www.serebii.net/pokemongo/pokemon/\(pokemonNumber).png",
                                           number: pokemonNumber,
//                                           pokedexInfo: "",
                                           types: [], 
                                           evolutionChain: [])
                        }
                        print(self.pokemons)
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
                pokemon.name.lowercased() == pokemonName.lowercased()
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
        
    static var standard: PokemonListModel = {
       let instance = PokemonListModel()
        
        return instance
    }()

    private init () {}
}

