//
//  FavoriteCollectionViewCell.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    let favoritesModel = FavoritesModel()
    var indexPath: IndexPath! {
        didSet {
            setupCell()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        let label = UILabel()
        print(favoritesModel.getLocation(at: indexPath).name)
        label.text = favoritesModel.getLocation(at: indexPath).name
        
        let view = UIView()
        
        view.addSubview(label)
    }
}
