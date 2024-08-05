//
//  EnvironmentExample.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI


// NOTE: preferenceKeys is used to pass props to parent elements in the hierarchy.

struct EnvironmentExample: View {
    // getting props from environment
    @Environment(\.dynamicTypeSize) private var dynamicType
    // Adding custom prop to be passed down to the child views
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello")
                    .environment(\.font, .caption2)
                Text("World")
                    .font(.title)
            }
        }
        
        Text("Another text")
        
        Text(dynamicType.isAccessibilitySize ? "Large text" : "Small text")
        
        .debugType()
    }
    
}

#Preview {
    EnvironmentExample()
}
