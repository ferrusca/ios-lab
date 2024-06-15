//
//  CurrencyModel.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import Foundation

struct Currency {
    var nombre: String
    var moneda: String
}

class CurrencyModel: BaseModel<Currency> {
    func getAll() throws {
        guard let url = Bundle.main.url(forResource: "Currency", withExtension: "json") else {
            throw CustomError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw CustomError.fileError }
        let currencyDTOs = try [CurrencyDTO](data: data)
        
        
        self.items = currencyDTOs.map { currencyDTO in
            return Currency(nombre: currencyDTO.nombre, moneda: currencyDTO.moneda)
        }
    }
    
    func getCurrencyFrom(country: String) -> Currency? {
        return items.first { currency in
            currency.nombre == country
        }
    }
}
