//
//  CircleImage.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI

struct CircleImage: View {
    let image: String
    
    private var imageURL: URL? {
        URL(string: image)
    }
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: imageURL,
                       content: { image in
                image
//                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle()
                            .stroke(Color.yellow,
                                    lineWidth: 5)
                    }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .frame(width: 200, height: 200)
            },
                       placeholder: {
                
                // show loader when app is downloaded
                ProgressView()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            })
        }
    }
}

#Preview {
    CircleImage(image: pokedex[1].imageURL)
}
