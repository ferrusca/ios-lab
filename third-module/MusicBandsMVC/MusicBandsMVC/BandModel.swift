//
//  BandModel.swift
//  MusicBandsMVC
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import Foundation


class BandModel {
    private var data: [String];
    
    init() {
        self.data = [
            "Aerosmith",
            "Alice Cooper",
            "Ozzy Osburne",
            "Tommy James",
            "Motley Crue",
            "Van Halen",
            "Def Leppard",
            "Bon Jovi",
            "Velvet Revolver",
            "Pet Shop Boys"
        ]
    }
    
    public func getMainTitle() -> String {
        "Rock bands"
    }
    
    public func getBand(_ indexPath: IndexPath) -> String {
        return self.data[indexPath.row];
    }
    
    public func getDataLength() -> Int {
        data.count
    }
    
}
