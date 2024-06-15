//
//  AddressDTO.swift
//  Fakestagram
//
//  Created by Jorge Ferrusca on 07/06/24.
//

import Foundation


// MARK: - Encodable/Decodable are protocols to transform data
struct AddressDTO: Decodable {
    var city: String
    var street: String
    var zipCode: String
    
    // map from original to new key values
    private enum CodingKeys: String, CodingKey {
        case city
        case street
        case zipCode = "zipcode"
    }
}
