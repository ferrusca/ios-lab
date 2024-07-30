//
//  PokemonLocationViewController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 21/06/24.
//

import UIKit
// Importing maps
import MapKit
// access to user location
import CoreLocation

class PokemonLocationViewController: UIViewController {
    private var viewModel = PokemonLocationViewModel()
    var pokemon: Pokemon!
    
    // creating map view
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: .realistic)
        mapView.showsUserLocation = true
        
        
        return mapView
    }()
    
    private lazy var closeButton: UIButton = {
       let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // adding target to the button
        button.addTarget(self,
                         action: #selector(closeButtonTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var showPokemonButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Show Pokemon"
    
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var showDirectionsButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Show Directions"
    
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(showDirectionsToPokemon), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func showDirectionsToPokemon() {
        viewModel.getDirectionsToPokemon()
    }
    
    init(pokemon: Pokemon) {
        super.init(nibName: nil, bundle: nil)
        print("poki es \(pokemon)")
        self.pokemon = pokemon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        mapView.delegate = self
        
        viewModel.pokemonLocation = pokemon.location
        
        
        setupView()
    }
    
    // Setup map
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        // adding map to main view
        view.addSubview(mapView)
        view.addSubview(closeButton)
        
        let pokemonInteractionStackView = UIStackView()
        pokemonInteractionStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonInteractionStackView.axis = .horizontal
        pokemonInteractionStackView.distribution = .fillProportionally
        pokemonInteractionStackView.addArrangedSubview(showPokemonButton)
        pokemonInteractionStackView.addArrangedSubview(showDirectionsButton)
        
        view.addSubview(pokemonInteractionStackView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            
            // pokemon button at the bottom
            pokemonInteractionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonInteractionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D) {
        // adding pin (aka annotation) with the new location that comes from PokemonLocationViewModelDelegate.
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = coordinate
        
        mapView.addAnnotation(userAnnotation)
        
        // focus upon specific region
        let mapRegion = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        )
        
        mapView.region = mapRegion
    }
    
    func showRouteBetween(userLocation: CLLocationCoordinate2D, pokemonLocation: Location) {
        let directionsRequest = MKDirections.Request()
        let pokemonCoordinates = CLLocationCoordinate2D(latitude: pokemonLocation.latitude,
                                                        longitude: pokemonLocation.longitude)
        
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: pokemonCoordinates))
        
        directionsRequest.transportType = .walking
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { [weak self] response, error in
            guard error == nil,
                  let response,
                  let route = response.routes.first
            else {
                return
            }
            
            self?.mapView.addOverlay(route.polyline)
        }
    }
}

extension PokemonLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = .green
        renderer.lineWidth = 8.0
        return renderer
    }
}


