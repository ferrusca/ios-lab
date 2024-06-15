//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import UIKit

class LoginViewController: UIViewController {
    var userModel = UserModel()
    var customView: LoginView {
        return view as! LoginView
    }
    private weak var router: MainRouter?
    
    init(router: MainRouter? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewConnections()
    }

    private func loginViewConnections() {
        customView.loginButton.addAction(UIAction(handler: attemptLocalLogin(_:)), for: .touchUpInside)
    }
    
    private func userNameValidation() -> Bool {
        customView.usernameTextfield.text?.isEmpty ?? false
    }
    
    private func login() {
        router?.logIn()
    }
    
}


// Extension to attempt the login
extension LoginViewController {
    func attemptLocalLogin(_ sender: UIAction) {
        guard let email = customView.usernameTextfield.text, !email.isEmpty else {
            return presentErrorAlert(title: "Error", message: "Please enter your email")
        }
        
//        do {
//            try userModel.findUser(by: email)
//            login()
//        } catch {
//            presentErrorAlert(title: "Error", message: error.localizedDescription)
//        }
        
        userModel.findUserFromExternalAPI(email: email) { [weak self] error in
            if let error {
                DispatchQueue.main.async {
                    self?.presentErrorAlert(title: "Error", message: error.localizedDescription)
                }
                
            } else {
                DispatchQueue.main.async {
                    self?.login()
                }
            }
        }
        
    }
}
