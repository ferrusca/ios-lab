//
//  MovieCollectionViewCell.swift
//  CollectionViewTableCell
//
//  Created by Jorge Ferrusca on 25/05/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    func setup(movie: Movie) -> Void {
        movieLabel.text = movie.title
        movieImageView.image = UIImage(named: movie.imagePath)
    }
    
}
