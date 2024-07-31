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
        starImageView.isHighlighted ? pokemonListModel.addToFavorites(pokemon: pokemon) : pokemonListModel.removeFromFavorites(pokemon: pokemon)
    }
    
    var chainedPokemons = [Pokemon]()
    let pokemonListModel = PokemonListModel.standard
    var pokemonDetailModel: PokemonDetailModel!
    public var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pokemon == nil {
            fatalError("Pokemon no encontrado!")
        }
        
        self.pokemonDetailModel = PokemonDetailModel(pokemon: pokemon)
        self.pokemonDetailModel.delegate = self
        self.pokemonDescription.textAlignment = .justified
        fetchPokemonImage(url: pokemon.image)
        
        initializeFavoriteIcon(pokemon: pokemon)
        initializeFavoriteIconGestureRecognizer()
        name.text = pokemon.name
        number.text = "# \(pokemon.number)"
        
        
        self.pokemonDetailModel.getDescription { [weak self] (error, pokedexInfo) in
            DispatchQueue.main.async {
                if let error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(.init(title: "OK", style: .default))
                    self?.present(alertController, animated: true)
                    return
                }
    
                
                self?.pokemonDescription.text = pokedexInfo
            }
        }
        
        
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
            guard let pokemonURL = URL(string: url) else {
                return print("Unable to fetch pokemon image. URL is empty")
            }
            let (data, _) = try await URLSession.shared.data(from: pokemonURL)
            imageView?.image = UIImage(data: data)
        }
    }
    
    private func initializeFavoriteIcon(pokemon: Pokemon) {
        starImageView.image = UIImage(systemName: "star")
        starImageView.highlightedImage = UIImage(systemName: "star.fill")
        starImageView.isHighlighted = pokemonListModel.isFavorite(pokemon: pokemon)
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

// Evolution chain
extension PokemonDetailViewController: PokemonDetailModelDelegate {
    func getPokemonChainFrom(endpoint: EndpointProtocol) {
        RequestHandler().get(endpoint) { (result: Result<EvolutionChainDTO, Error>) in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let response):
                print("All good in evolution chain")
                self.pokemon.evolutionChain = [
                    response.chain.species.name,
                    response.chain.evolvesTo[0].species.name,
                    response.chain.evolvesTo[0].evolvesTo[0].species.name
                ]
                
                self.chainedPokemons = self.pokemonListModel.getPokemonEvolutionChainDetail(self.pokemon)
                DispatchQueue.main.async {
                    self.chainedTableView.dataSource = self
                    self.chainedTableView.delegate = self
                    
                }
            }
        }
    }
}
