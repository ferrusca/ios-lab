//
//  FavoriteButton.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

struct FavoriteButton: View {
    // Allows the parent to detect any change in this var
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button(action: {
            isFavorite.toggle()
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.title)
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    FavoriteButton(isFavorite: .constant(false))
}
