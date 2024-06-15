//
//  ConversionModel.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import Foundation

struct CurrencyConversion {
    let countryCode: String
    let conversionFactors: [String: Double]
}

class CurrencyConversionModel: BaseModel<CurrencyConversion> {
    func getAll() throws {
        guard let url = Bundle.main.url(forResource: "CurrencyConversion", withExtension: "json") else {
            throw CustomError.fileError
        }
        
        guard let data = try? Data(contentsOf: url) else { throw CustomError.fileError }
        
        let currencyConversionDTO = try JSONDecoder().decode([[String: [String: Double]]].self, from: data)
        var currencyConversion: [CurrencyConversion] = []
        
        for currency in currencyConversionDTO {
            for nestedValue in currency {
                currencyConversion.append(
                    CurrencyConversion(
                        countryCode: nestedValue.key,
                        conversionFactors: nestedValue.value
                    )
                )
            }
        }
            
        self.items = currencyConversion
    }
    
    private func getCurrencyMapFrom(countryCode: String) -> [String: Double] {
        return items.first { item in
            item.countryCode == countryCode
        }?.conversionFactors ?? [:]
    }
        
    public func getCurrencyConversion(sourceCountryCode: String, targetCountryCode: String) -> Double {
        return getCurrencyMapFrom(countryCode: sourceCountryCode)[targetCountryCode] ?? 1.0
    }
    
    public func getCountryCodeList() -> [String] {
        return self.items.map { $0.countryCode }
    }
}
