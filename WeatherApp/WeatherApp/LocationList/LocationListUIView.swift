//
//  LocationListUIView.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import SwiftUI

struct LocationListUIView: View {
    let locations = LocationListModel().getLocations()
    
    var body: some View {
        Text("Locations")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
        NavigationStack {
            List(locations) { location in
                NavigationLink(destination: {
                    WrappedLocationView(location: location)
                }) {
                    LocationRow(location: location)
                }
            }
        }
    }
}

#Preview {
    LocationListUIView()
}
