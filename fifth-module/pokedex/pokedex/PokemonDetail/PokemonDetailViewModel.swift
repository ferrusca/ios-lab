//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 21/06/24.
//

import Foundation
import UIKit

// AnyObject added to allow "weak var" in the var delegate
protocol PokemonDetailViewModelDelegate: AnyObject {
    func updatePokemonImage(to image: UIImage)
}

class PokemonDetailViewModel {
    private let pokemon: Pokemon
    
    
    var pokemonName: String { pokemon.name }
    
    // Dependency counter does not increase thanks to "weak var". Preventing from memory leaks
    weak var delegate: PokemonDetailViewModelDelegate?
    
    init(with pokemon: Pokemon) {
        self.pokemon = pokemon
        
        if let pokemonImageURL = URL(string: pokemon.imageURL) {
            fetchPokemonImage(from: pokemonImageURL)
        }
    }
    
    private func fetchPokemonImage(from url: URL) {
        // on async calls, use clousure list to avoid memory retention
        // If we'd use weak var, then "self" would become optional
        DispatchQueue.global().async { [unowned self] in
            // make sure self exists at the time the image is being set
//            guard let self = self else { return }
            
            if let imageData = try? Data(contentsOf: url),
                let pokemonImage = UIImage(data: imageData) {
               
                DispatchQueue.main.async {
                    self.delegate?.updatePokemonImage(to: pokemonImage)
                }
            }
        }
    }
}
