//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import Foundation

struct Location: Identifiable, Decodable, Encodable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "nombre"
    }
}

class LocationListModel {
    private var locations: [Location] = []
    private let dataFilename = "LocationList"
    private let dataFileExtension = "json"
    
    init() {
        locations = loadLocations()
    }
    
    public func getLocations() -> [Location] {
        return locations
    }
    
    private func loadLocations() -> [Location] {
        guard let fileURL = Bundle.main.url(forResource: dataFilename,
                                            withExtension: dataFileExtension),
              let data = try? Data(contentsOf: fileURL),
              let locations = try? JSONDecoder().decode([Location].self, from: data)
        else {
            // stops here when in dev mode. In production this error is not thrown
            assertionFailure("Cannot read file \"\(dataFilename)\"")
            return []
        }

        return locations
    }
}
