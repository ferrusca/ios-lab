//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chainedTableView: UITableView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pokemonDescription: UITextView!
    
    
    
    @objc func toggleFavorite(tapGestureRecognizer: UITapGestureRecognizer) {
        starImageView.isHighlighted = !starImageView.isHighlighted
        starImageView.isHighlighted ? pokemonModel.addToFavorites(pokemon: pokemon) : pokemonModel.removeFromFavorites(pokemon: pokemon)
    }
    
    var chainedPokemons = [Pokemon]()
    let pokemonModel = PokemonModel.standard
    public var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pokemon == nil {
            fatalError("Pokemon no encontrado!")
        }
        
        fetchPokemonImage(url: pokemon.image)
        chainedPokemons = pokemonModel.getPokemonEvolutionChainDetail(pokemon)
        chainedTableView.dataSource = self
        chainedTableView.delegate = self
        initializeFavoriteIcon(pokemon: pokemon)
        initializeFavoriteIconGestureRecognizer()
        name.text = pokemon.name
        number.text = "#\(pokemon.number)"
        pokemonDescription.text = pokemon.pokedexInfo
    }
    
    private func initializeFavoriteIconGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(toggleFavorite(tapGestureRecognizer:))
        )
        starImageView.isUserInteractionEnabled = true
        starImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func fetchPokemonImage(url: String) {
        Task { [weak imageView] in
                let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
                imageView?.image = UIImage(data: data)
        }
    }
    
    private func initializeFavoriteIcon(pokemon: Pokemon) {
        starImageView.image = UIImage(systemName: "star")
        starImageView.highlightedImage = UIImage(systemName: "star.fill")
        starImageView.isHighlighted = pokemonModel.isFavorite(pokemon: pokemon)
    }
}

extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chainedPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        let chainedPokemon = chainedPokemons[indexPath.row]
        cellContent.text = chainedPokemon.name
        cellContent.secondaryText = "# \(chainedPokemon.number)"
        cell.contentConfiguration = cellContent;
        
        return cell
    }
}

// Table view click handler
extension PokemonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonViewController = PokemonDetailViewController(nibName: "PokemonDetailViewController", bundle: nil)
        pokemonViewController.pokemon = self.chainedPokemons[indexPath.row]
        
        navigationController?.pushViewController(pokemonViewController, animated: true)
    }
}
