//
//  NestedUiKitView.swift
//  PokedexSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

struct NestedUiKitView: View {
    @State private var someText = "Some text"
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            WrappedUIKitView(text: someText)
                .frame(width: 200, height: 200)
            
            
            
            VStack {
                Spacer()
                
                Button("Change text") {
                    someText = "Updated text!"
                    print(someText)
                }
            }
        }
    }
}

struct WrappedUIKitView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Data was updated")
        
        guard let label = uiView.subviews.first as? UILabel else { return }
        label.text = text
    }
    
    let text: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.borderColor = Color.cyan.cgColor
        view.layer.borderWidth = 5
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, World!"
        label.textColor = .magenta
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
}

#Preview {
    NestedUiKitView()
}
