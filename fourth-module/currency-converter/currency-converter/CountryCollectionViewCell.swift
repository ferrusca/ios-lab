//
//  CountryCollectionViewCell.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public func setup(countryName: String, imagePath: String?) {
        if imagePath != nil {
            imageView.image = UIImage(named: "\(imagePath!).png")
        }
        label.text = countryName
    }
}
