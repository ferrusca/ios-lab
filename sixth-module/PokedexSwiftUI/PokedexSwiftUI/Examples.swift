//
//  Examples.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI

struct Examples: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                }.debugType()
            
            UnderlineView(content: Text("Foobarbaz"))
            UnderlineView(content: Image(systemName:  "star"))
            Text("This is another text")
                .modifier(UnderlineViewModifier())
        }
    }
}


struct UnderlineView<Content: View>: View {
    var content: Content
    
    var body: some View {
        content
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 1)
            }
        
    }
}

struct UnderlineViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 1)
            }
        
    }
}

extension View {
    func underline() -> some View {
        modifier(UnderlineViewModifier())
    }
}

// Display the type of element
extension View {
    func debugType() -> Self {
        let type = Mirror(reflecting: self).subjectType
        print(type)
        return self
    }
}

struct Examples2: View {
    let counter = 0
    let optionalCounter: Int? = .some(1)
    
    var body: some View {
        VStack {
            switch counter > 0 {
            case true:
                Circle()
            case false:
                Rectangle()
            }
            
            if let counter = optionalCounter {
                Text("Randomly Printed: \(counter)")
            }
            
            Button(action: {}) {
                Text("Btn always rendered")
            }
        }
        .debugType()
    }
}


struct Example3: View {
    var body: some View {
//        Text("Favorite")
//            .frame(width: 30)
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.orange)
            .frame(width: 150, height: 100)
        
        // Case with padding
        Text("Favorites")
            .border(Color.red)
            .padding(50)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

struct Example4: View {
    var body: some View {
        HStack(spacing:10) {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            // In stack, `Text` element is the least flexible
            // initial `layoutPriority` is 0
            Text("A simple text")
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .layoutPriority(2)
            
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.green)
        }
        .frame(width: 200, height: 40)
    }
}

#Preview {
    Example4()
}
