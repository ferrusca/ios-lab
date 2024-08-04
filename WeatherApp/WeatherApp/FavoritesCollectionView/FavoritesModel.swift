//
//  FavoritesModel.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import Foundation
import UIKit

class FavoritesModel {
    private var locations: [Location] = []
    private var locationsFilename = "favoriteLocations"
    private var locationsFileExtension = "json"
    public var total: Int { locations.count }
    public let cellIdentifier = "favoriteLocationCell"
    
    init() {
        self.locations = loadLocations()
        
        // Saving data from favorite locations when app is going inactive
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeLocations),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    private func loadLocations() -> [Location] {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first
        else {
            assertionFailure("Cannot find the documents directory")
            return []
        }

        let fileURL = documentsDirectoryURL.appendingPathComponent("favoriteLocations.json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            let foo = try JSONDecoder().decode([Location].self, from: data)
            
            print(foo)
            return foo
        } catch {
            print(error)
            return []
        }
    }
    
    @objc private func storeLocations() {
        print("storing locations")
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else { return }
        
        let fileURL = documentsDirectory.appending(
            component: "\(locationsFilename).\(locationsFileExtension)"
        )
        let favoriteLocations = Array(self.locations)
        print(favoriteLocations)
        
        do {
            let locationsData = try JSONEncoder().encode(favoriteLocations)
            let jsonLocations = String(data: locationsData, encoding: .utf8)
            
            try jsonLocations?.write(to: fileURL,
                                  atomically: true,
                                  encoding: .utf8)
        } catch {
            assertionFailure("Failed storing favorite locations")
        }
    }
    
    public func addLocation(location: Location) {
        print("adding location")
        self.locations.append(location)
        
        // forcing save
        storeLocations()
    }
    
    public func removeLocation(_ locationToDelete: Location) {
        self.locations = self.locations.filter { location in
            location.name != locationToDelete.name
        }
        
        storeLocations()
    }
    
    public func isFavorite(location: Location) -> Bool {
        let favorite = locations.first(where: { iLocation in
            iLocation.name == location.name
        })
        
        return favorite != nil
    }
    
    public func getLocation(at: IndexPath) -> Location {
        return self.locations[at.row]
    }
    
    
    public func getAll() -> [Location] {
        return self.locations
    }
}
