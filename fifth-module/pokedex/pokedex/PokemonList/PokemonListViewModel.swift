//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 21/06/24.
//

import Foundation
import UIKit

protocol PokemonListViewModeDelegate: AnyObject {
    func shouldReloadInformation()
}

class PokemonListViewModel {
//  access modifiers: fileprivate, private, internal (default), public
    
    private let pokemonDataFileName = "pokemon_list"
    private let pokemonDataFileExtension = "json"
    private var pokemonList = [Pokemon]()
    private var favoritePokemonList = Set<Pokemon>()
    
    let cellIdentifier = "pokemonCellIdentifier"
    var pokemonCount: Int { pokemonList.count }
    let title = "Pokédex"
    
    weak var delegate: PokemonListViewModeDelegate?
    
    init() { 
        pokemonList = loadPokemonData()
        favoritePokemonList = Set(loadFavoritePokemonList())
        
        // Adding this class as observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveFavoritePokemon),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    private func loadPokemonData() -> [Pokemon] {
        guard let fileURL = Bundle.main.url(
            forResource: pokemonDataFileName,
            withExtension: pokemonDataFileExtension
        ),
              let data = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: data)
        else {
            // stops here when in dev mode. In production this error is not thrown
            assertionFailure("Cannot read file \"\(pokemonDataFileName)\"")
            return []
        }
        
        return pokemonList
    }
    
    private func loadFavoritePokemonList() -> [Pokemon] {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first
        else {
            assertionFailure("Cannot find the documents directory")
            return []
        }

        let fileURL = documentsDirectoryURL.appendingPathComponent("favoritePokemon.json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            let favoritePokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
            
            return favoritePokemonList
        } catch {
//            assertionFailure("Failed with message: \(error.localizedDescription)")
            return []
        }
    }
    
    func pokemon(at: IndexPath) -> Pokemon {
        return pokemonList[at.row]
    }
    
    func addToFavorites(at indexPath: IndexPath) {
        print("adding to")
        favoritePokemonList.insert(pokemon(at: indexPath))
        delegate?.shouldReloadInformation()
        saveFavoritePokemon()
    }
    
    @objc private func saveFavoritePokemon() {
        print("hola!!!")
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else { return }
        
        let filename = "favoritePokemon.json"
        let fileURL = documentsDirectory.appending(component: filename)
        let favoritePokemon = Array(favoritePokemonList)
        
        do {
            let favoritePokemonData = try JSONEncoder().encode(favoritePokemon)
            let jsonFavoritePokemon = String(data: favoritePokemonData, encoding: .utf8)
            
            try jsonFavoritePokemon?.write(to: fileURL,
                                           atomically: true,
                                           encoding: .utf8)
        } catch {
            assertionFailure("Failed storing favorite pokemon")
        }
    }
    
    func addPokemonToFavorites(at indexPath: IndexPath) {
        let pokemon = pokemon(at: indexPath)
        favoritePokemonList.insert(pokemon)
        delegate?.shouldReloadInformation()
        saveFavoritePokemon()
    }
    
    func isPokemonInFavorites(_ pokemon: Pokemon) -> Bool {
        favoritePokemonList.contains(pokemon)
    }
}
