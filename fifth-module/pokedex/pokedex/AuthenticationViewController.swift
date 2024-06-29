//
//  AuthenticationViewController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import UIKit
// MARK:
import LocalAuthentication

class AuthenticationViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        // prevent interactive dismissal
        isModalInPresentation = true
        
        view.backgroundColor = .systemBackground
        
        let containerStackView = UIStackView()
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        
        let authLabel = UILabel()
        authLabel.text = "Please authenticate to view the favorite pokemons"
        // automatically adjust font size
        authLabel.adjustsFontForContentSizeCategory = true
        authLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        authLabel.numberOfLines = 0
        
        var authButtonConfiguration = UIButton.Configuration.filled()
        authButtonConfiguration.title = "Authenticate"
        
        let authButton = UIButton(configuration: authButtonConfiguration)
        authButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.addTarget(self,
                             action: #selector(authenticateButtonTapped),
                             for: .touchUpInside)
        
        view.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(authLabel)
        containerStackView.addArrangedSubview(authButton)
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func authenticateButtonTapped() {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "we need to verify your identity"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, error in
                    if success {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                        }
                    }
            }
        }
        
        // TODO: - Add in info file the property to be used (Privacy - Face ID Usage Description)
    }
}
