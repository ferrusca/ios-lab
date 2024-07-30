//
//  ContentView.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView(sidebar: {
            List(pokedex) { pokemon in
                NavigationLink(destination: {
                    PokemonDetailView(pokemon: pokemon)
                }, label: {
                    PokemonRow(pokemon: pokemon)
                })
            }
            .navigationTitle("Pokedex")
        }, detail: {
            Text("Select a Pokemon")
        })
    }
}

#Preview {
    ContentView()
}
