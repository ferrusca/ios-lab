//
//  NavigationTabBarController.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import UIKit

class NavigationTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let pizzaListViewController = PizzaListTableViewController(style: .insetGrouped)
        pizzaListViewController.tabBarItem.title = "All pizzas"
        pizzaListViewController.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        pizzaListViewController.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.clipboard.fill")
        
        let pizzaListNavigationController = UINavigationController(
            rootViewController: pizzaListViewController
        )
        
        let customPizzaListViewController = CustomPizzaListTableViewController(style: .insetGrouped)
        customPizzaListViewController.tabBarItem.title = "My Selections"
        customPizzaListViewController.tabBarItem.image = UIImage(systemName: "star")
        customPizzaListViewController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let customPizzaListNavigationController = UINavigationController(
            rootViewController: customPizzaListViewController
        )
        
        let pizzaShopListViewController = PizzaShopListTableViewController(style: .insetGrouped)
        pizzaShopListViewController.tabBarItem.title = "Pizza Shops"
        pizzaShopListViewController.tabBarItem.image = UIImage(systemName: "storefront")
        pizzaShopListViewController.tabBarItem.selectedImage = UIImage(systemName: "storefront.fill")
        
        let pizzaShopListNavigationController = UINavigationController(
            rootViewController: pizzaShopListViewController
        )
        
        
        viewControllers = [
            pizzaListNavigationController,
            customPizzaListNavigationController,
            pizzaShopListNavigationController
        ]
    }

}
