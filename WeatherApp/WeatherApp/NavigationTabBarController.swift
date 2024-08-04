//
//  NavigationTabBarController.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import UIKit
import SwiftUI

class NavigationTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    

    private func setupViewControllers() {
        let locationUIViewController = UIHostingController(rootView: LocationListUIView())
        
        locationUIViewController.tabBarItem.title = "Location"
        locationUIViewController.tabBarItem.image = UIImage(systemName: "mappin.circle")
        locationUIViewController.tabBarItem.selectedImage = UIImage(systemName: "mappin.circle.fill")
        
//        let favoritesCollectionViewController = FavoritesCollectionViewController(style: .insetGrouped)
        let favoritesCollectionViewController = FavoritesCollectionViewController()
        
        favoritesCollectionViewController.tabBarItem.title = "Favorites"
        favoritesCollectionViewController.tabBarItem.image = UIImage(systemName: "star")
        favoritesCollectionViewController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let favoritesCollectionNavigationController = UINavigationController(
            rootViewController: favoritesCollectionViewController
        )
        
        
        viewControllers = [
            locationUIViewController,
            favoritesCollectionNavigationController,
        ]
    }

}
