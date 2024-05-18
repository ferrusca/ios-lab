//
//  CustomTableViewCell.swift
//  MyFirstTable
//
//  Created by Jorge Ferrusca on 17/05/24.
//

import UIKit


// MARK: Prototype cells don't exist in XIB context
class CustomTableViewCell: UITableViewCell {
     @IBOutlet weak var cellTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
