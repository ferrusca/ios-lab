//
//  PokemonDetailView.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI
import MapKit

struct PokemonDetailView: View {
    //  This var is a clousure type
    @Environment(\.pokemonSoundAction) private var pokemonSoundAction
    
    let pokemon: Pokemon
    
    private var coordinate: CLLocationCoordinate2D? {
        guard let location = pokemon.location else { return nil }
        
        return CLLocationCoordinate2D(latitude: location.latitude,
                                      longitude: location.longitude)
    }
    
    private func mapRegion() -> MKCoordinateRegion? {
        guard let coordinate = coordinate else { return nil }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
    
    
    
    var body: some View {
        VStack(alignment: .center) {
            if let region = mapRegion(), let coordinate {
                Map(initialPosition: .region(region)) {
                    Marker(pokemon.name, coordinate: coordinate)
                    Marker(coordinate: coordinate) {
                        AsyncImage(url: URL(string: pokemon.imageURL)!)
                    }
                }
                .frame(height: 300)
            }
            CircleImage(image: pokemon.imageURL)
                .offset(y: -125)
                .padding(.bottom, -160)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            Text(pokemon.name)
                .font(.largeTitle)
            HStack(alignment: .bottom) {
                Text("No.\(pokemon.number)")
                Text(pokemon.type[0])
                Spacer()
            }
            
            Button("Play pokemon name") {
                pokemonSoundAction()
            }
            
            Spacer()
        }
            
    }
}

#Preview {
    PokemonDetailView(pokemon: pokedex[22])
}
