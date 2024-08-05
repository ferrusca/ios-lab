//
//  ViewController.swift
//  EmbeddedSwiftUI
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func didTapShowSwiftUI(_ sender: Any) {
        print("hola")
        // presenting SwiftUI view
        let swiftUIViewController = UIHostingController(rootView: MySwiftUIView())
        
        navigationController?.pushViewController(swiftUIViewController, animated: true)
    }
    

    @IBAction func didTapShowSwiftUIView(_ sender: Any) {
        navigationController.
    }

}

