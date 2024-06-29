//
//  FavoritePokemonListViewModel.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import Foundation

class FavoritePokemonListViewModel {
    private var pokemonList = Array<Pokemon>()
    var numberOfSections: Int { 1 }
    var numberOfRows: Int { pokemonList.count }
    let reuseCellIdentifier: String = "favoritePokemonCell"
    
    init() {
        pokemonList = loadFavoritePokemonList()
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
            
            return try JSONDecoder().decode([Pokemon].self, from: data)
        } catch {
//            assertionFailure("Failed with message: \(error.localizedDescription)")
            return []
        }
    }
    
    func pokemon(at: IndexPath) -> Pokemon {
        return pokemonList[at.row]
    }
}
