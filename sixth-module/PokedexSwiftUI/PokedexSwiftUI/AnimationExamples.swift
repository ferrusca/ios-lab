//
//  AnimationExamples.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

struct AnimationExamples: View {
    @State private var count = 0
    @State private var count2 = 0
    
    var body: some View {
        VStack {
            Circle()
                .fill(count2.isMultiple(of: 2) ? Color.blue : Color.green)
                .frame(width: 50, height: 50)
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, 
                       alignment: count.isMultiple(of: 2) ? .leading : .trailing)
                .border(Color.black)
            
            
            Button("Animate") {
                // explicit animation (commented out)
//                withAnimation {
                    count = count + 1
//                }
            }
            
            Button("Start another animation") {
                count2 = count2 + 1
            }
        }
        
        // view modifier
        .animation(.easeInOut, value: count)
        .animation(.default, value: count2)
    }
}

// struct that defines a custom animation
struct Shake: ViewModifier, Animatable {
    var count: CGFloat = 0
    
    init(count: CGFloat) {
        self.count = count
    }
    
    var animatableData: CGFloat {
        get { count }
        set { count = newValue }
    }
    
    func body(content: Content) -> some View {
        print("count right now is \(count)")
        let offset = -sin(count * 2 * .pi) * 20
        return content.offset(x: offset)
    }
}

extension View {
    func shake(count: CGFloat) -> some View {
        modifier(Shake(count: count))
    }
}

struct MyAnimationExamples2: View {
    @State private var count: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .shake(count: count)
            
            Button("Shake the text") {
                withAnimation {
                    count = count + 1
                }
            }
        }
    }
}

#Preview {
//    AnimationExamples()
    MyAnimationExamples2()
}
