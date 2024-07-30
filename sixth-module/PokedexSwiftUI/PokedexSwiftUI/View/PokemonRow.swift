//
//  PokemonRow.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    
    private var imageURL: URL? {
        URL(string: pokemon.imageURL)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            // Donwloading image from internet
            if let imageURL {
                AsyncImage(url: imageURL,
                           content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                },
                           placeholder: {
                    
                    // show loader when app is downloaded
                    ProgressView()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                })
            }
            
            
            Text(pokemon.name)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        
    }
}

#Preview {
    PokemonRow(pokemon: pokedex.first!)
}
