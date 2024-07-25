//
//  NavigationTabBarController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import UIKit

class NavigationTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let pokemonListViewController = PokemonListTableViewController(style: .insetGrouped)
        pokemonListViewController.tabBarItem.title = "Pokemon"
        pokemonListViewController.tabBarItem.image = UIImage(systemName: "lizard")
        
        // embedding in a navigation controller
        let pokemonNavigationController = UINavigationController(rootViewController: pokemonListViewController)
        
        
        let favoritePokemonViewController = FavoritePokemonListTableViewController(style: .insetGrouped)
        favoritePokemonViewController.tabBarItem.title = "Favorites"
        favoritePokemonViewController.tabBarItem.image = UIImage(systemName: "star")
        
        let favoritePokemonNavigationController = UINavigationController(rootViewController: favoritePokemonViewController)
        
        
        // list of navigation controllers to present
        viewControllers = [
            pokemonNavigationController,
            favoritePokemonNavigationController
        ]
    }
}
