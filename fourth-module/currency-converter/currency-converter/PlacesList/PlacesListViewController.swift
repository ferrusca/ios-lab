//
//  PlacesListViewController.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import UIKit

class PlacesListViewController: UIViewController {
    public var state: String!
    private let pointOfInterestModel = PointOfInterestModel()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        try? pointOfInterestModel.getAll()
        tableView.dataSource = self
    }
}

extension PlacesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pointOfInterestModel.getPointsOfInterestFrom(state: state).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = pointOfInterestModel.getPointsOfInterestFrom(state: state)[indexPath.row]
        cell.contentConfiguration = cellContent;
      
        return cell
    }
}
