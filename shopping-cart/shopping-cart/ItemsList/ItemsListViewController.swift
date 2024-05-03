//
//  ItemsListViewController.swift
//  shopping-cart
//
//  Created by Jorge Ferrusca_C on 13/04/24.
//

import UIKit

class ItemsListViewController: UIViewController {
    var cart: [String] = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleProduct(sender: UIButton) {
        let product = sender.titleLabel?.text
        if let productIndex = cart.firstIndex(of: product!) {
            cart.remove(at: productIndex)
            sender.backgroundColor = .blue
            sender.setImage(UIImage(systemName: "cart"), for: .normal)
        } else {
            cart.append(product!)
            sender.backgroundColor = .green
            sender.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        }
    }
    
    @IBAction func goToCartUsingXIB() {
        let cartViewController = CartViewController(nibName: "CartView", bundle: nil)
        
        cartViewController.modalPresentationStyle = .fullScreen
        cartViewController.itemsText = cart.count == 0 ? "No items selected" : "Your items are: \(cart.joined(separator: ", "))"
        
        present(cartViewController, animated: false)

    }


}
