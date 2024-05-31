//
//  ItemCollectionViewCell.swift
//  TabBarShoppingList
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(productName: String) -> Void {
        label.text = productName
        imageView.image = UIImage(systemName: "\(productName.first?.lowercased() ?? "questionmark").circle.fill")
    }
    

}
