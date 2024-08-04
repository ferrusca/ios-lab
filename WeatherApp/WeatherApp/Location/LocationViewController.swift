//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    var weather: CurrentWeatherResponse!
    var location: Location!
    var currentDegrees = "celsius"
    let hStack = UIStackView()
    var celsiusDegrees = 0.0
    var farenheitDegrees = 0.0
    let favoritesModel = FavoritesModel()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.text = self.weather.locationInfo.region
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let image = UIImage(systemName: "circle.fill")

        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: "star")
        imageView.highlightedImage = UIImage(systemName: "star.fill")
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(toggleFavorite(tapGestureRecognizer:))
        )
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        return imageView
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.text = self.currentDegrees == "farenheit"
            ? "\(self.weather.currentConditions.farenheitDegrees)°F"
            : "\(self.weather.currentConditions.celsiusDegrees)°C"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var uvLabel: UILabel = {
        let label = UILabel()
        label.text = "U.V: \(weather.currentConditions.uv)"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    @objc func scaleChanged() {
        degreesLabel.text = scaleSegmentedControl.selectedSegmentIndex == 0 ? "\(celsiusDegrees)°C" : "\(farenheitDegrees)°F"
    }
    
    private lazy var scaleSegmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["°C", "°F"])
       segmentedControl.selectedSegmentIndex = 0
       segmentedControl.addTarget(self, action: #selector(scaleChanged), for: .valueChanged)
       segmentedControl.translatesAutoresizingMaskIntoConstraints = false
       
       return segmentedControl
   }()

    private lazy var localtimeLabel: UILabel = {
        let label = UILabel()
        label.text = weather.locationInfo.localtime.replacingOccurrences(of: "-", with: "/")
        label.font = .preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.preferredConfiguration = MKStandardMapConfiguration()
        mapView.showsUserLocation = true
        
        
        return mapView
    }()
    
    private lazy var lastUpdateLabel: UILabel = {
        let label = UILabel()
        label.text = "Last update: \(weather.currentConditions.lastUpdated.replacingOccurrences(of: "-", with: "/"))"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    
    init(location: Location) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
        WeatherModel().currentWeatherFrom(location: location) {
            [weak self] (error, response) in
                DispatchQueue.main.async {
                    if let error {
                        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(.init(title: "OK", style: .default))
                        self?.present(alertController, animated: true)
                        return
                    }
                    if let response {
                        self?.weather = response
                        self?.setupView()
                        self?.setLayoutConstraints()
                        self?.fetchWeatherImage(url: response.currentConditions.condition.icon)
                        self?.view.superview?.backgroundColor = response.currentConditions.isDay == 1 ? UIColor(hex: "#87CEEB") : UIColor(hex: "#191970")
                        self?.view.superview?.setFontColor(response.currentConditions.isDay == 1 ? UIColor.black : UIColor.white)

                        self?.celsiusDegrees = response.currentConditions.celsiusDegrees
                        self?.farenheitDegrees = response.currentConditions.farenheitDegrees
                        
                        // focus upon specific region
                        let mapRegion = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: response.locationInfo.lat,
                                                           longitude: response.locationInfo.lon),
                            span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                        )
                        
                        self?.mapView.region = mapRegion
                    }
                }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parent?.title = location?.name ?? "Default"
        self.title = location?.name ?? "Default"
    }
    
    private func fetchWeatherImage(url: String) {
        Task { [weak weatherImageView] in
            guard let weatherURL = URL(string: "https:\(url)") else {
                return print("Unable to fetch weather image. URL is empty")
            }
            let (data, _) = try await URLSession.shared.data(from: weatherURL)
            weatherImageView?.image = UIImage(data: data)?.resized(to: CGSize(width: 50, height: 30))
        }
    }
    
    @objc func toggleFavorite(tapGestureRecognizer: UITapGestureRecognizer) {
        starImageView.isHighlighted = !starImageView.isHighlighted
        starImageView.isHighlighted 
            ? favoritesModel.addLocation(location: location)
            : favoritesModel.removeLocation(location)
    }

    private func setupView() {
        self.starImageView.isHighlighted = self.favoritesModel.isFavorite(location: location)
        
        view.addSubview(regionLabel)
        view.addSubview(starImageView)
        
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.addArrangedSubview(weatherImageView)
        hStack.addArrangedSubview(degreesLabel)
        hStack.addArrangedSubview(uvLabel)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scaleSegmentedControl)
        view.addSubview(hStack)
        view.addSubview(localtimeLabel)
        view.addSubview(mapView)
        view.addSubview(lastUpdateLabel)
    }
    
    private func setLayoutConstraints() {
//        let margin = 26
        let margin = 0.0
        
        NSLayoutConstraint.activate([
            regionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            regionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            starImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: margin),
            starImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            scaleSegmentedControl.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 40),
            scaleSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            hStack.topAnchor.constraint(equalTo: scaleSegmentedControl.bottomAnchor, constant: 50),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.heightAnchor.constraint(equalToConstant: 100),
            hStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            localtimeLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 40),
            localtimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mapView.topAnchor.constraint(equalTo: localtimeLabel.bottomAnchor, constant: 40),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            
            lastUpdateLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 30),
            lastUpdateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            
            
            
        ])
    }
}
