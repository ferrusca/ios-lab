//
//  PokemonListTableViewController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 21/06/24.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    let viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Registering cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pokemonCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // passing indexPath as 2nd argument returns a non-optional cell
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier,
                                                 for: indexPath)

        let pokemon = viewModel.pokemon(at: indexPath)
        
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = pokemon.name
        cellConfigurator.secondaryText = pokemon.number
        
        cell.contentConfiguration = cellConfigurator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPokemon = viewModel.pokemon(at: indexPath)
        let pokemonDetailViewController = PokemonDetailViewController(pokemon: selectedPokemon)
        navigationController?.pushViewController(pokemonDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoritesAction = UIContextualAction(style: .normal, title: "Add to Favorites") {
            [weak self] _, _, completition in
            self?.viewModel.addToFavorites(at: indexPath)
            completition(true)
        }
        
        favoritesAction.backgroundColor = .systemYellow
        favoritesAction.image = UIImage(systemName: "star")
        
        return UISwipeActionsConfiguration(actions: [favoritesAction])
    }
}

extension PokemonListTableViewController: PokemonListViewModeDelegate {
    func shouldReloadInformation() {
        tableView.reloadData()
    }
}
