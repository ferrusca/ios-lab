//
//  PokemonList.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI

struct PokemonList: View {
    var body: some View {
//        List {
//                PokemonRow(pokemon: pokedex[0])
//                PokemonRow(pokemon: pokedex[1])
//                PokemonRow(pokemon: pokedex[2])
//                PokemonRow(pokemon: pokedex[3])
//        }
        
        // OR
        
        // After adding Identifiable protocol in `Pokemon`, we can omit the id property
//        List(pokedex, id: \.id) { pokemon in
        List(pokedex) { pokemon in
            PokemonRow(pokemon: pokemon)
        }
        
        
    }
}

#Preview {
    PokemonList()
}
