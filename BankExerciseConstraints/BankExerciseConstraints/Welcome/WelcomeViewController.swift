//
//  WelcomeViewController.swift
//  BankExerciseConstraints
//
//  Created by Jorge Ferrusca_C on 06/04/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var welcomeText: String = "Welcome, "
    @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = welcomeText
    }
    
    @IBAction func manualSegueDealsUsingXIB() {
        let dealsViewController = DealsViewController(nibName: "DealsViewController", bundle: nil)
         
        // push to perform horizontal navigation
        navigationController?.pushViewController(dealsViewController, animated: true)
    }


}
