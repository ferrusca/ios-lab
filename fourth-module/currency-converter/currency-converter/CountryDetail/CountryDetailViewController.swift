//
//  CountryDetailViewController.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var country: Country!
    let currencyModel = CurrencyModel()
    let countryDetailModel = CountryDetailModel()
    let stateModel = StateModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = country.name
        try? currencyModel.getAll()
        try? countryDetailModel.getAll()
        try? stateModel.getAll()
        tableView.reloadData()
        setCountryInformation()
        try? PointOfInterestModel().getAll()
    }
    
    func setCountryInformation() -> Void {
        let countryInfo = countryDetailModel.getDetails(country: country.name)
        
        if country.imagePath != nil {
            imageView.image = UIImage(named: "\(country.imagePath!).png")
        }
        
        self.label.text = """
            Capital: \(countryInfo?.capital ?? "Unknown")
            Language: \(countryInfo?.idioma ?? "Unknown")
            Currency: \(currencyModel.getCurrencyFrom(country: country.name)?.moneda ?? "Unknown")
        """
    }
}

extension CountryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stateModel.getStatesFrom(country: country.name).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = stateModel.getStatesFrom(country: country.name)[indexPath.row]
        cell.contentConfiguration = cellContent;
      
        return cell
    }
}

// Table view click handler
extension CountryDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60.0
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placesListViewController = PlacesListViewController(nibName: "PlacesListViewController", bundle: nil)
        placesListViewController.state = stateModel.getStatesFrom(country: country.name)[indexPath.row]
        
        navigationController?.pushViewController(placesListViewController, animated: true)
    }
}

