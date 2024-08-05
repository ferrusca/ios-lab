//
//  SwiftUIView.swift
//  EmbeddedSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

struct MySwiftUIView: View {
    var body: some View {
        ZStack {
            Color.pink
            Text("This is a SwiftUI view")
                .font(.largeTitle)
//                .foregroundStyle()
        }
    }
}

#Preview {
    MySwiftUIView()
}
