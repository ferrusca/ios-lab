//
//  CartViewController.swift
//  shopping-cart
//
//  Created by Jorge Ferrusca_C on 13/04/24.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var itemsTextview: UITextView!
    var itemsText: String = "";

    override func viewDidLoad() {
        super.viewDidLoad()

        itemsTextview.text = itemsText;
    }
}
