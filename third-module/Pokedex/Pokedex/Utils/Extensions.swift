//
//  Extensions.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import Foundation

// Generic way to be able to decode to the class used - eg. MyAwesomeDTO(data: data)
extension Decodable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

// Serializes the passed data
extension Data {
    init(from object: Encodable) throws {
        self = try JSONEncoder().encode(object)
    }
}
