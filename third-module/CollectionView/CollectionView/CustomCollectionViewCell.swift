//
//  CustomCollectionViewCell.swift
//  CollectionView
//
//  Created by Jorge Ferrusca on 24/05/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    func setup(movie: String) -> Void {
        movieLabel.text = movie
        movieImageView.image = UIImage(named: movie)
    }
    
}
