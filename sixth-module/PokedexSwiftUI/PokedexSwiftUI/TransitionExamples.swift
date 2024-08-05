//
//  TransitionExamples.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

struct TransitionExamples: View {
    @State private var textIsShown = false
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            if (textIsShown) {
                Text("\(counter)")
//                    .transition(.slide.combined(with: /*@START_MENU_TOKEN@*/.identity/*@END_MENU_TOKEN@*/))
                    .id(counter)
                    .transition(.asymmetric(insertion: .slide, removal: .opacity))
            }
            
            
            Button("Toggle") {
                withAnimation(.bouncy(duration: 2)) {
//                    textIsShown.toggle()
                    counter += 1
                }
            }
        }
        
        
    }
}

#Preview {
    TransitionExamples()
}
