//
//  StateModel.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import Foundation

struct CountryState {
    var estados: [String]
    var country: String
}

class StateModel: BaseModel<CountryState> {
    func getAll() throws {
        guard let url = Bundle.main.url(forResource: "Capitals", withExtension: "json") else {
            throw CustomError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw CustomError.fileError }
        print("funciona")
        let statesJSON = try JSONDecoder().decode([[String: [State]]].self, from: data)
         
        var countryStates: [CountryState] = []
        
        for (country, cities) in statesJSON[0] {
            let cityNames = cities.map { $0.estado }
            countryStates.append(CountryState(estados: cityNames, country: country))
        }
        self.items = countryStates
        
        print(self.items)
    }
    
    func getStatesFrom(country: String) -> [String] {
        return items.first { countryState in
            countryState.country == country
        }?.estados ?? []
    }
}
