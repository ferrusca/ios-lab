//
//  PokemonsViewController.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class PokemonsViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var filteredPokemons = [Pokemon]()
    
    let pokemonModel = PokemonListModel.standard
    
    private func customizeSearchBar() {
        // customizing search bar appearance
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundImage = UIImage()
//        self.searchBar.barTintColor = .red
        self.searchBar.searchTextField.backgroundColor = .white
    }

    override func viewDidLoad() {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar(searchBar, textDidChange: "")
        imageView.layer.zPosition = -1000;
        customizeSearchBar()
    }
    
}

extension PokemonsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonModel.getAllFromAPI { [weak self] error in
            DispatchQueue.main.async {
                if let error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(.init(title: "OK", style: .default))
                    self?.present(alertController, animated: true)
                    return
                }
                self?.filteredPokemons = self?.pokemonModel.getPokemons(searchText: searchText) ?? []
                self?.tableView.reloadData()
            }
        }
        
    }
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        let pokemon = filteredPokemons[indexPath.row]
        cellContent.text = pokemon.name
        cellContent.secondaryText = "# \(pokemon.number)"
        cell.contentConfiguration = cellContent;
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// Table view click handler
extension PokemonsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60.0
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonViewController = PokemonDetailViewController(nibName: "PokemonDetailViewController", bundle: nil)
        pokemonViewController.pokemon = self.filteredPokemons[indexPath.row]
        
        navigationController?.pushViewController(pokemonViewController, animated: true)
    }
}
