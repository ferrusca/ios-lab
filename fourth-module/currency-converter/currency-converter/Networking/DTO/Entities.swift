//
//  Entities.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import Foundation

struct CountryDTO: Decodable {
    var id: Int
    var nombre: String
}

struct CountryDetailsDTO: Decodable {
    var nombre: String
    var capital: String
    var idioma: String
}

struct CurrencyDTO: Decodable {
    var nombre: String
    var moneda: String
}

struct FlagsDTO: Decodable {
    let data: [String: String]
    
    // Custom initializer to handle dynamic keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var flagsDict = [String: String]()
        
        for key in container.allKeys {
            let value = try container.decode(String.self, forKey: key)
            flagsDict[key.stringValue] = value
        }
        
        self.data = flagsDict
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
}

struct State: Decodable {
    let estado: String
}


//struct CountryWithStates: Decodable {
//    let country: String
//    let states: [State]
//   
//    // Unknown
//    struct CodingKeys: CodingKey {
//        var stringValue: String
//                var intValue: Int? = nil
//
//                init?(stringValue: String) {
//                    self.stringValue = stringValue
//                }
//
//                init?(intValue: Int) {
//                    return nil
//                }
//    }
//
//    // Custom initializer to handle dynamic keys and store the key
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        var countriesWithStates: [State] = []
//        
//        print(container.allKeys)
//        
//        for key in container.allKeys {
//            let states = try container.decode(State.self, forKey: key)
//            let country = key
//            countriesWithStates.append(<#T##newElement: State##State#>)
//        }
//
//        self.country = key
//        self.states = statesArray
//    }
//}

//struct StateDTO: Decodable

//struct StateDTO {
//    var estado: String
//    var Lugares: [String]
//}

struct PointOfInterestDTO: Decodable {
    let state: String
    let places: [String]
    
    enum CodingKeys: String, CodingKey {
        case state = "estado"
        case places = "lugares"
    }
}


