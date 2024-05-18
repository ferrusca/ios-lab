//
//  SongModel.swift
//  MusicBandsMVC
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import Foundation

struct Song {
    var albumId: Int;
    var name: String;
    var duration: String
}

class SongModel {
    private var albums: [Album]
    
    init() {
        self.albums = [
            Album(id: 1, bandName: "Aerosmith", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 2, bandName: "Aerosmith", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 3, bandName: "Alice Cooper", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 4, bandName: "Alice Cooper", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 5, bandName: "The Eagles", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 6, bandName: "The Eagles", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 7, bandName: "Tommy James", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 8, bandName: "Tommy James", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 9, bandName: "Motley Crue", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 10, bandName: "Motley Crue", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 11, bandName: "Van Halen", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 12, bandName: "Van Halen", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 13, bandName: "Def Leppard", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 14, bandName: "Def Leppard", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 15, bandName: "Bon Jovi", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 16, bandName: "Bon Jovi", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 17, bandName: "Velvet Revolver", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 18, bandName: "Velvet Revolver", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil),
            Album(id: 19, bandName: "Pet Shop Boys", name: "Awesome album", releaseYear: 1999, coverPath:  nil),
            Album(id: 20, bandName: "Pet Shop Boys", name: "Awesome album 2", releaseYear: 1987, coverPath:  nil)
        ]
    }
    
    public func getBandAlbums(band: String) -> [Album] {
        return self.albums.filter { album in
            album.bandName == band
            
        }
    }
}
