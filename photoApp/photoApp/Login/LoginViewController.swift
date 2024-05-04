//
//  LoginViewController.swift
//  photoApp
//
//  Created by Jorge Ferrusca_C on 12/04/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!

    
    // detects if segue has been tiggered
    // Note: this doesn't work anymore since now segue is triggered manually
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeNavigationController = segue.destination as? UINavigationController {
            if let username = usernameTextField.text, !username.isEmpty {
                homeNavigationController.topViewController?.navigationItem.title = "Welcome, \(username.capitalized)"
            } else {
                homeNavigationController.topViewController?.navigationItem.title = "Welcome"
            }
        }
    }
    
    private func presentView(_ homeNavigationController: UINavigationController) {
        if let username = usernameTextField.text, !username.isEmpty {
            homeNavigationController.topViewController?.navigationItem.title = "Welcome, \(username.capitalized)"
        } else {
            homeNavigationController.topViewController?.navigationItem.title = "Welcome"
        }
        
        // Presenting view
        present(homeNavigationController, animated: false)
    }
    
    private func homeViewUsingStoryboard() -> Void {
        // Instantiating storyboard from "Main"
        guard let homeNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else { return }
        
        presentView(homeNavigationController)
      
    }
    
    private func homeViewUsingXIB() {
        let homeViewController = HomeViewController(nibName: "HomeView", bundle: nil)
        // creating a navigation controller
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        // present view
        homeNavigationController.modalPresentationStyle = .fullScreen
        homeNavigationController.navigationBar.prefersLargeTitles = true
        
        // MAKING SAME VALIDATION AND PRESENTATION AGAIN
        presentView(homeNavigationController)
    }
    
    // Manually trigger segue
    @IBAction func manualSegueHome(_: UIButton) -> Void {
        // Can use both methods to display
//        homeViewUsingStoryboard();
        homeViewUsingXIB()
    }
    
    

}
