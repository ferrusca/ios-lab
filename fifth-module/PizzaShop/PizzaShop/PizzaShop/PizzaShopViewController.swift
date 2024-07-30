//
//  PizzaShopViewController.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 27/07/24.
//

import UIKit
import MapKit

class PizzaShopViewController: UIViewController {
    private var pizzaShop: PizzaShop!
    private var viewModel = PizzaShopViewModel();
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pizzaShop.name
        
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pizzaShop.address
    
        return label
    }()
    
    // create map
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: .realistic)
        mapView.showsUserLocation = true
        
        
        return mapView
    }()
    
    private lazy var getRoutesButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Get Routes"
        config.cornerStyle = .capsule
    
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(showDirectionsToPizzaShop), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        var config = UIButton.Configuration.filled()
    
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRectMake(0, 0, 20, 20)
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.tintColor = .lightGray
        
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showDirectionsToPizzaShop() {
        guard let coordinates = pizzaShop.coordinates else {
            return showDirectionsNotFoundAlert()
        }
        viewModel.showDirectionsToPizzaShop(location: coordinates)
    }
    
    private func showDirectionsNotFoundAlert() {
        let alertController = UIAlertController(title: "Pizza shop location not found",
                                                message: "Unable to get directions since the location is unknown", 
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setLayoutConstraints()
    }
    
    init(shop: PizzaShop) {
        super.init(nibName: nil, bundle: nil)
        mapView.delegate = self
        viewModel.delegate = self
        self.pizzaShop = shop
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 600),
            
            closeButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            getRoutesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getRoutesButton.heightAnchor.constraint(equalToConstant: 50),
            getRoutesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            getRoutesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35)
        ])
    }
    
    private func setupView() {
        title = ""
        addressLabel.numberOfLines = 0
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(addressLabel)
        view.addSubview(getRoutesButton)
    }
}


// Delegating MapView to render the route
extension PizzaShopViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = .magenta
        renderer.lineWidth = 7.0
        return renderer
    }
}

// Delegating viewModel
extension PizzaShopViewController: PizzaShopViewModelDelegate {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D) {
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
    
    func showRouteBetween(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        
        let directionsRequest = MKDirections.Request()
    
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
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
            
            // Adding the pizza shop annotation
            let pizzaShopAnnotation = MKPointAnnotation()
            pizzaShopAnnotation.coordinate = destination
            
            self?.mapView.addAnnotation(pizzaShopAnnotation)
        }
    }
}
    
