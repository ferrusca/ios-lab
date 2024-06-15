//
//  CountryDetailModel.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import Foundation

struct CountryDetail {
    var nombre: String
    var capital: String
    var idioma: String
}

class CountryDetailModel: BaseModel<CountryDetail> {
    func getAll() throws {
        guard let countriesURL = Bundle.main.url(forResource: "CountriesDetails", withExtension: "json") else {
            throw CustomError.fileError
        }
        guard let countriesData = try? Data(contentsOf: countriesURL) else { throw CustomError.fileError }
        let countryDetailsDTO = try [CountryDetailsDTO](data: countriesData)
        
        
        self.items = countryDetailsDTO.map { countryDetailDTO in
            return CountryDetail(nombre: countryDetailDTO.nombre, capital: countryDetailDTO.capital, idioma: countryDetailDTO.idioma)
        }
    }
    
    func getDetails(country: String) -> CountryDetail? {
        return items.first { countryDetail in
            countryDetail.nombre == country
        }
    }
}
