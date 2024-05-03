//
//  ViewController.swift
//  background-color-lamp
//
//  Created by Jorge Ferrusca_C on 06/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lampButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var isLampOn: Bool = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        toggleLampState();
    }
    
    @IBAction func lampButtonChanged(_ sender: UIButton) {
        toggleLampState()
    }
    
    func toggleLampState() {
        isLampOn = !isLampOn
        lampButton.setTitle(isLampOn ? "Turn off" : "Turn on!", for: .normal)
        self.view.backgroundColor = isLampOn ? UIColor.white : UIColor.black
        imageView.image = isLampOn ? .sun : .moon
    }

}

