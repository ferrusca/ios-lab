//
//  PointOfInterestModel.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 14/06/24.
//

import Foundation

struct PointOfInterest {
    let state: String
    let places: [String]
}

class PointOfInterestModel: BaseModel<PointOfInterest> {
    func getAll() throws {
        guard let url = Bundle.main.url(forResource: "PointsOfInterest", withExtension: "json") else {
            throw CustomError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw CustomError.fileError }
        print("funciona poi")
        let pointsOfinterestDTO = try JSONDecoder().decode([String: [[String: [PointOfInterestDTO]]]].self, from: data)
         
        var pointsOfInterest: [PointOfInterest] = []
        
        for country in pointsOfinterestDTO["Paises"]?[0] ?? [:] {
            for state in country.value {
                pointsOfInterest.append(PointOfInterest(state: state.state, places: state.places))
            }
        }
        self.items = pointsOfInterest
        
        print(self.items)
    }
    
    func getPointsOfInterestFrom(state: String) -> [String] {
        return items.first { item in
            item.state == state
        }?.places ?? []
    }
}
