//
//  PokemonSoundEnvironment.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

public typealias PokemonSoundAction = () -> Void

public struct PokemonSoundEnvironmentKey: EnvironmentKey {
    public static let defaultValue: PokemonSoundAction = {
        print("Sound for this pokemon is not implemented yet")
    }
}

public extension EnvironmentValues {
    var pokemonSoundAction: PokemonSoundAction {
        get {
            self[PokemonSoundEnvironmentKey.self]
        }
        
        set {
            self[PokemonSoundEnvironmentKey.self] = newValue
        }
    }
}
