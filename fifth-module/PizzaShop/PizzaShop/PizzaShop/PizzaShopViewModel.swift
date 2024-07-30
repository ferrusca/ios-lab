//
//  PizzaShopViewModel.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 27/07/24.
//

import CoreLocation
import Foundation
import UIKit

protocol PizzaShopViewModelDelegate where Self: UIViewController {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D)
    func showRouteBetween(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D)
}

class PizzaShopViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D? {
        willSet {
            if let newValue {
                delegate?.updateUserLocation(with: newValue)
            }
        }
    }
    weak var delegate: PizzaShopViewModelDelegate?
    
    public func showDirectionsToPizzaShop(location: Coordinates) {
        guard let userLocation else {
            fatalError("Unable to get directions, user location was not found")
        }
        
        let source = userLocation
        let destination = CLLocationCoordinate2D(latitude: location.latitude,
                                                 longitude: location.longitude)
        
        delegate?.showRouteBetween(source: source, destination: destination)
    }
    
    // "override init" syntax since we're extending from NSObject
    override init() {
        super.init()
        setupLocationManager()
    }
    
    // MARK: DON'T FORGET TO ADD THE REQUIRED PERMISSIONS TO INFO.PLIST
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}


// get the latest location of the user
extension PizzaShopViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        let coordinate2d = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude,
                                                longitude: lastLocation.coordinate.longitude)
        
        userLocation = coordinate2d
    }
}
