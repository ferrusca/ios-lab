//
//  LoginViewController.swift
//  BankExerciseConstraints
//
//  Created by Jorge Ferrusca_C on 13/04/24.
//

import UIKit

class LoginViewController: UIViewController {

//    let USERNAME = "Diplomado2024"
//    let PASSWORD = "jorge_10"
    
    let USERNAME = "jorge"
    let PASSWORD = "jorge"
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func characterTyped() {
        if let usernameText = usernameTextField?.text, let passwordText = passwordTextField?.text {
            print("isenabled")
            loginButton.isEnabled = usernameText.count > 0 && passwordText.count > 0
               
            
        } else {
            loginButton.isEnabled = false
        }
    }
    
    // NOT needed anymore since now using XIB instead of storyboard
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let welcomeViewController = segue.destination as? WelcomeViewController {
//            
//        }
//    }
    
    private func manualSegueWelcomeUsingXIB() {
        let welcomeViewController = WelcomeViewController(nibName: "WelcomeView", bundle: nil)
        // creating a navigation controller
        // present view
        
        let welcomeNavigationController = UINavigationController(rootViewController: welcomeViewController)
        // present view
        welcomeNavigationController.modalPresentationStyle = .fullScreen
        welcomeNavigationController.navigationBar.prefersLargeTitles = true
        
        welcomeViewController.welcomeText = "Welcome, \(USERNAME)"
        
        present(welcomeNavigationController, animated: true)
    }
    
    @IBAction func login() {
        if (usernameTextField.text == USERNAME && passwordTextField.text == PASSWORD) {
            manualSegueWelcomeUsingXIB()
        }
        
        showErrorAlert()
    }

    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Datos Incorrectos", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertController, animated: true)
    }

}
