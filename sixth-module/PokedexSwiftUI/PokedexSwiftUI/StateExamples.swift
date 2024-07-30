//
//  StateExamples.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 26/07/24.
//

import SwiftUI

struct Counter: View {
    // state should remain private, so no one else can modify this state
    @State private var count: Int = 0
    
    var body: some View {
        VStack {
            Button(
                action: {
                // Use property wrapper @state to fix the immutable issue
                    count += 1
                },
                label: {
                    Text("\(count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            )
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

// Use `ObservableObject` so that swift observes this class and notify the change to the subscribers of this property
class MyStateObjectClass: ObservableObject {
    @Published var count = 0
}

struct StateObjectExample: View {
    @StateObject private var model = MyStateObjectClass()
    
    var body: some View {
        Button("Tap me") {
            model.count += 1
        }
        
        Text("Count: \(model.count)")
    }
}

struct CounterView: View {
    @State private var tapCount = 0
    
    var body: some View {
        VStack {
            if tapCount > 0 {
                Text("Tapped: \(tapCount) times")
            }
            
//            TapMeView(tapCount: Binding(get: { tapCount }, set: { tapCount = $0 }))

            // OR simplified
            TapMeView(tapCount: $tapCount)
        }
    }
}

struct TapMeView: View {
    @Binding internal var tapCount: Int
    
    var body: some View {
        Button("Tap me") {
            tapCount += 1
        }
    }
}

#Preview {
//    Counter()
//    StateObjectExample()
    CounterView()
}
