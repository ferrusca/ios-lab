//
//  WrappedLocationView.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import SwiftUI

struct WrappedLocationView: View {
    let location: Location
    
    var body: some View {
        WrappedUIKitView(
            location: location
        )
    }
}

#Preview {
    WrappedLocationView(location: Location(id: 10, name: "Argentina"))
}


struct WrappedUIKitView: UIViewControllerRepresentable {
    let location: Location
    
    func updateUIViewController(_ uiViewController: LocationViewController, context: Context) {
        print("Data was updated")
        
//        guard let label = uiView.subviews.first as? UILabel else { return }
//        label.text = text
    }
    

    
    func makeUIViewController(context: Context) -> LocationViewController {
        let viewController = LocationViewController(location: location)
        
        return viewController
    }
}
