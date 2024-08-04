//
//  LocationRow.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import SwiftUI

struct LocationRow: View {
    let location: Location
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            
            Image(location.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
            
            Text(location.name)
                .font(.subheadline)
                .fontWeight(.bold)
            
//                .onTapGesture {
//                    print("hola2")
//                    print(location)
//                }

            
            Spacer()
        }
    }
}

#Preview {
    LocationRow(location: Location(id: 6, name: "Spain"))
}
