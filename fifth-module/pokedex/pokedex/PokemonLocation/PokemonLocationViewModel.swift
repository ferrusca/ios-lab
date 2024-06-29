//
//  PokemonLocationViewModel.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 22/06/24.
//

import Foundation
import CoreLocation
import UIKit

// Restricting implementation of this delegate to UIViewController instances only.
protocol PokemonLocationViewModelDelegate where Self: UIViewController {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D)
    func showRouteBetween(userLocation: CLLocationCoordinate2D, pokemonLocation: Location)
}

class PokemonLocationViewModel: NSObject {
    // NOTE: Add to infoplist the location permission with a description "(Privacy - Location When In Use Usage Description)"
    
    private let locationManager = CLLocationManager()
    
    weak var delegate: PokemonLocationViewModelDelegate?
    
    public var pokemonLocation: Location? {
        didSet {
            if let location = pokemonLocation {
                updatePokemonLocation(location)
            }
        }
    }
    
    private var userLocation: CLLocationCoordinate2D? {
        willSet {
            if let newValue {
                delegate?.updateUserLocation(with: newValue)
            }
        }
    }
  
    // "override init" syntax since we're extending from NSObject
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func updatePokemonLocation(_ location: Location) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                longitude: location.longitude)
        
        delegate?.updateUserLocation(with: coordinate)
    }
    
    func getDirectionsToPokemon() {
            guard let userLocation, let pokemonLocation = pokemonLocation else { return }
            
            delegate?.showRouteBetween(userLocation: userLocation,
                                       pokemonLocation: pokemonLocation)
    }
    
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // ask for user permission
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    // runs every time the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude,
                                                longitude: lastLocation.coordinate.longitude)
        
        userLocation = coordinate
    }
}
