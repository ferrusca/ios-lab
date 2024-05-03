//
//  LoremViewController.swift
//  photoApp
//
//  Created by Jorge Ferrusca_C on 12/04/24.
//

import UIKit

class LoremViewController: UIViewController {
    @IBOutlet weak var loremTextView: UITextView!
    
    var loremText = "This is our default text";

    override func viewDidLoad() {
        super.viewDidLoad()
        setLoremText()
    }
    
    private func setLoremText() {
        loremTextView.text = loremText;
    }

}
