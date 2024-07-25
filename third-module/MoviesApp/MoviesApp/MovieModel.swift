//
//  MovieModel.swift
//  CollectionViewTableCell
//
//  Created by Jorge Ferrusca on 25/05/24.
//

import Foundation

enum Genre: CaseIterable {
    case animation, drama, fantasy
}

struct Movie {
    let title: String
    let genre: Genre
    let rating: Double
    let imagePath: String
}

class MovieModel {
    private var movies: [Movie] = [
        Movie(title: "Despicable Me 4", genre: .animation, rating: 10.0, imagePath: "despicableMe"),
        Movie(title: "Shrek", genre: .animation, rating: 10.0, imagePath: "shrek"),
        Movie(title: "Sing 2", genre: .animation, rating: 10.0, imagePath: "sing2"),
        Movie(title: "The Garfield Movie", genre: .animation, rating: 10.0, imagePath: "garfield"),
        Movie(title: "Kung Fu Panda 4", genre: .animation, rating: 10.0, imagePath: "kungFuPanda"),
        Movie(title: "Inside Out 2", genre: .animation, rating: 10.0, imagePath: "insideOut"),
        Movie(title: "The Incredibles", genre: .animation, rating: 10.0, imagePath: "incredibles"),
        Movie(title: "Spider-Man: Across the Spider-Verse", genre: .animation, rating: 10.0, imagePath: "spiderMan"),
        Movie(title: "Despicable Me 4", genre: .drama, rating: 10.0, imagePath: "despicableMe"),
        Movie(title: "Shrek", genre: .drama, rating: 10.0, imagePath: "shrek"),
        Movie(title: "Sing 2", genre: .drama, rating: 10.0, imagePath: "sing2"),
        Movie(title: "The Garfield Movie", genre: .drama, rating: 10.0, imagePath: "garfield"),
        Movie(title: "Kung Fu Panda 4", genre: .drama, rating: 10.0, imagePath: "kungFuPanda"),
        Movie(title: "Inside Out 2", genre: .drama, rating: 10.0, imagePath: "insideOut"),
        Movie(title: "The Incredibles", genre: .drama, rating: 10.0, imagePath: "incredibles"),
        Movie(title: "Spider-Man: Across the Spider-Verse", genre: .drama, rating: 10.0, imagePath: "spiderMan"),
        Movie(title: "Despicable Me 4", genre: .fantasy, rating: 10.0, imagePath: "despicableMe"),
        Movie(title: "Shrek", genre: .fantasy, rating: 10.0, imagePath: "shrek"),
        Movie(title: "Sing 2", genre: .fantasy, rating: 10.0, imagePath: "sing2"),
        Movie(title: "The Garfield Movie", genre: .fantasy, rating: 10.0, imagePath: "garfield"),
        Movie(title: "Kung Fu Panda 4", genre: .fantasy, rating: 10.0, imagePath: "kungFuPanda"),
        Movie(title: "Inside Out 2", genre: .fantasy, rating: 10.0, imagePath: "insideOut"),
        Movie(title: "The Incredibles", genre: .fantasy, rating: 10.0, imagePath: "incredibles"),
        Movie(title: "Spider-Man: Across the Spider-Verse", genre: .fantasy, rating: 10.0, imagePath: "spiderMan"),


    ]
    
    public func getMoviesFilter(genre: Genre) -> [Movie] {
        return movies.filter({ $0.genre == genre })
    }
}

