//
//  ModelData.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import Foundation

let pokedex: [Pokemon] = load("pokemon_list.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Cannot find \(filename) in bundle.")
    }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Could not load data from file \(filename)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse the file data")
    }
}
