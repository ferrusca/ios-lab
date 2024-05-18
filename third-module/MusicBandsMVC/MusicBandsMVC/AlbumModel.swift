//
//  AlbumModel.swift
//  MusicBandsMVC
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import Foundation

struct Song {
    let name: String;
    let duration: String;
}

struct Album {
    var id: Int;
    var bandName: String;
    var name: String
    var releaseYear: Int
    var coverPath: String
    var songs: [Song]
}

class AlbumModel {
    private var albums: [Album]
    
    init() {
        self.albums = [
            Album(id: 1, bandName: "Aerosmith", name: "Get a grip", releaseYear: 1999, coverPath:  "get-a-grip", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                Album(id: 2, bandName: "Aerosmith", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
            Album(id: 3, bandName: "Alice Cooper", name: "Trash", releaseYear: 1999, coverPath:  "trash", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                     Album(id: 4, bandName: "Alice Cooper", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                              Album(id: 5, bandName: "Ozzy Osburne", name: "Bark at the Moon", releaseYear: 1999, coverPath:  "bark-at-the-moon", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Album(id: 6, bandName: "Ozzy Osburne", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Album(id: 7, bandName: "Tommy James", name: "Christian of the World", releaseYear: 1999, coverPath:  "christian-of-the-world", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Album(id: 8, bandName: "Tommy James", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Album(id: 9, bandName: "Motley Crue", name: "Threatre of pain", releaseYear: 1999, coverPath:  "threatre-of-pain", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Album(id: 10, bandName: "Motley Crue", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Album(id: 11, bandName: "Van Halen", name: "5150", releaseYear: 1999, coverPath:  "5150.jpeg", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Album(id: 12, bandName: "Van Halen", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
            Album(id: 13, bandName: "Def Leppard", name: "Pyromania", releaseYear: 1999, coverPath:  "pyromania.jpeg", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Album(id: 14, bandName: "Def Leppard", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Album(id: 15, bandName: "Bon Jovi", name: "Awesome album", releaseYear: 1999, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Album(id: 16, bandName: "Bon Jovi", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Album(id: 17, bandName: "Velvet Revolver", name: "Awesome album", releaseYear: 1999, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Album(id: 18, bandName: "Velvet Revolver", name: "Awesome album 2", releaseYear: 1987, coverPath:  "", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")]),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Album(id: 19, bandName: "Pet Shop Boys", name: "introspective", releaseYear: 1999, coverPath:  "introspective.jpeg", songs: [Song(name: "Song 1", duration: "3:33"), Song(name: "Song 2", duration: "7:22")])
]
}

public func getBandAlbums(band: String) -> [Album] {
    return self.albums.filter { album in
        album.bandName == band
        
    }
}
}
