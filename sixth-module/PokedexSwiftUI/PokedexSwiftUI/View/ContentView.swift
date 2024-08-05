//
//  ContentView.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI
// Base audio/video class
import AVFoundation




struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var speechSyntesizer = AVSpeechSynthesizer()
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(pokedex) { pokemon in
                NavigationLink(destination: {
                    PokemonDetailView(pokemon: pokemon)
                        .environment(\.pokemonSoundAction, {
                            if !speechSyntesizer.isSpeaking {
                                let utterance = AVSpeechUtterance(string: "Hey I'm \(pokemon.name)")
                                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                
                                speechSyntesizer.speak(utterance)
                            }
                        })
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
