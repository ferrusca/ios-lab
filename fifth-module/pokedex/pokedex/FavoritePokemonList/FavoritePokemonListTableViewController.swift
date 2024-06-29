//
//  FavoritePokemonListTableViewController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import UIKit

class FavoritePokemonListTableViewController: UITableViewController {
    let viewModel = FavoritePokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cell
        tableView.register(UITableViewCell.self,
                             forCellReuseIdentifier: viewModel.reuseCellIdentifier)
    }
    
    // when is about to be presented...
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: this presents the FACE id modal
//        navigationController?.present(AuthenticationViewController(), animated: animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseCellIdentifier, for: indexPath)
        
        let pokemon = viewModel.pokemon(at: indexPath)
        
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = pokemon.name
        cellConfigurator.secondaryText = pokemon.number
        
        cell.contentConfiguration = cellConfigurator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let favoritePokemonDetailViewController = FavoritePokemonDetailViewController()
        navigationController?.pushViewController(favoritePokemonDetailViewController, animated: true)
    }
    
}
