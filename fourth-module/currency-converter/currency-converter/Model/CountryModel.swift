//
//  CountryModel.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import Foundation

enum CustomError: Error, LocalizedError {
    case fileError
    
    var errorDescription: String? {
        switch self {
        case .fileError: "File error"
        }
    }
}

class BaseModel<T> {
    var items: [T] = []
    
    init () {}
    
    public func getItem(index: Int) -> T {
        return items[index]
    }
    
    public func getNumberOfItems() -> Int {
        return items.count
    }
}

struct Country {
    var id: Int
    var name: String
    var imagePath: String?
}

class CountryModel: BaseModel<Country> {
    func getAll() throws {
        // getting countries
        guard let countriesURL = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            throw CustomError.fileError
        }
        guard let countriesData = try? Data(contentsOf: countriesURL) else { throw CustomError.fileError }
        let countriesDTO = try [CountryDTO](data: countriesData)
        
        // getting flags
        guard let flagsURL = Bundle.main.url(forResource: "Flags", withExtension: "json") else {
            throw CustomError.fileError
        }
        guard let flagsData = try? Data(contentsOf: flagsURL) else { throw CustomError.fileError }
        let flagsDTO = try FlagsDTO(data: flagsData)
        
        self.items = countriesDTO.map { countryDTO in
            let imagePath = flagsDTO.data.first { $0.key == countryDTO.nombre }
            return Country(id: countryDTO.id, name: countryDTO.nombre, imagePath: imagePath?.value)
        }
    }
}
