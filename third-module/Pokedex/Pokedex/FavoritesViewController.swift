//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var filteredPokemons = [Pokemon]()
    
    let pokemonListModel = PokemonListModel.standard
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar(searchBar, textDidChange: searchBar.text ?? "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        imageView.layer.zPosition = -1000;
    }
    
}

extension FavoritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemons = pokemonListModel.getFavorites(searchText: searchText)
        
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", 
                                                 for: indexPath)
        
        var cellContent = cell.defaultContentConfiguration()
        let pokemon = filteredPokemons[indexPath.row]
        cellContent.text = pokemon.name
        cellContent.secondaryText = "# \(pokemon.number)"
        cell.contentConfiguration = cellContent;
        
        return cell
    }
}

// Table view click handler
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonViewController = PokemonDetailViewController(nibName: "PokemonDetailViewController", bundle: nil)
        pokemonViewController.pokemon = self.filteredPokemons[indexPath.row]
        
        navigationController?.pushViewController(pokemonViewController, animated: true)
    }
}
