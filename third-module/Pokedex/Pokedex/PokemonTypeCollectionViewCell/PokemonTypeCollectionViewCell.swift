//
//  PokemonTypeCollectionViewCell.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 01/06/24.
//

import UIKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func setup(type: PokemonTypeDamage) -> Void {
        label.text = type.name
        imageView.image = UIImage(named: type.imagePath)
        imageView.clipsToBounds = true
    }

}
