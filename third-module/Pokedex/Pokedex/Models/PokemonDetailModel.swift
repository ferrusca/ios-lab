//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 30/07/24.
//

import Foundation

struct EvolutionChain: Decodable {
    let url:  String
}

struct DescriptionLanguage: Decodable {
    let name: String
    let url: String
}

struct TextEntry: Decodable {
    let description: String
    let language: DescriptionLanguage
    
    private enum CodingKeys: String, CodingKey {
        case language
        case description = "flavor_text"
    }
}

struct PokemonDescriptionResponse: Decodable {
    let textEntries: [TextEntry]
    let evolutionChain: EvolutionChain
    
    // modifying response keys
    private enum CodingKeys: String, CodingKey {
        case textEntries = "flavor_text_entries"
        case evolutionChain = "evolution_chain"
    }
}

class PokemonDetailModel: NSObject {
    private var pokemon: Pokemon!
    
    private let language = "es"
    
    weak var delegate: PokemonDetailModelDelegate?
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    private func buildEndpoint(pokemonId: Int) -> EndpointProtocol {
        return UserBaseEndpoint(path: "/pokemon-species/\(pokemonId)")
    }
    
    public func getDescription(completitionHandler: @escaping (Error?, String) -> Void) {
        RequestHandler().get(buildEndpoint(pokemonId: pokemon.id)) {
            (result: Result<PokemonDescriptionResponse, Error>) in
            switch result {
            case .failure(let failure):
                print(failure)
                completitionHandler(failure, "")
            case .success(let response):
                let evolutionChain = response.evolutionChain.url.split(separator: "/")
                
                // removing the api host (https://pokeapi...)
                let urlSuffix = "/\(Array(evolutionChain.suffix(2)).joined(separator: "/"))"
               
                self.delegate?.getPokemonChainFrom(endpoint: UserBaseEndpoint(
                    path: urlSuffix
                ))
                
                
                // retrieving the first description in the setted language
                var pokedexInfo = response.textEntries.first(
                    where: { $0.language.name == self.language }
                )?.description ?? 
                // if not found, get the english description
                response.textEntries.first(
                    where: { $0.language.name == "us" }
                )?.description ?? "No description found!"
                
                // removing new line chars
                pokedexInfo = pokedexInfo.replacingOccurrences(of: "\n", with: " ")
                
                completitionHandler(nil, pokedexInfo)
            }
        }
    }
}
