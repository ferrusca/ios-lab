//
//  HomeViewController.swift
//  photoApp
//
//  Created by Jorge Ferrusca on 05/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    // casting the view to our HomeView1 type
    var customView: HomeView1 {
        
        return view as! HomeView1
    }
    
    // These are not needed anymore since view was created programatically
//    @IBOutlet weak var pictureTypeSwitch: UISwitch!
//    @IBOutlet weak var showCaptionSwitch: UISwitch!
//    @IBOutlet weak var customTextSwitch: UISwitch!
//    @IBOutlet weak var picsButton: UIButton!
//    @IBOutlet weak var customTextView: UITextView! {
//        didSet {
//            customText.delegate = self
//        }
//    }
    
    // This is equivalent to linking UI elements with @IBAction's
    private func connectActionsWithHomeView() {
        customView.pictureTypeSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        customView.picsButton.addTarget(self, action: #selector(picsClickPresentSegue(_:)), for: .touchUpInside)
        customView.customTextSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    // since XIBs are only views, need to programatically add navigation bars and the items of ButtonItemGroup
    private func setBarButtonItemGroup() {
        let logoutButton = UIBarButtonItem(title: "Logout", image: UIImage(systemName: "multiply.circle.fill"), target: self, action: #selector(logout))
        
        let infoButton = UIBarButtonItem(title: "Info", image: UIImage(systemName: "info.circle.fill"), target: self, action: #selector(manualSegueInfo))
        
        let infoUsingXIBButton = UIBarButtonItem(title: "Info XIB", image: UIImage(systemName: "info.circle.fill"), target: self, action: #selector(manualSegueInfoUsingXIB))
        
        self.navigationItem.centerItemGroups = [UIBarButtonItemGroup.fixedGroup(items: [infoButton, infoUsingXIBButton, logoutButton])]
    }
    
    override func loadView() {
        // instantiating the UIView manually created
        view = HomeView1()
    }
    
    override func viewDidLoad() {
        setBarButtonItemGroup()
        // linking button and switch actions
        connectActionsWithHomeView()
    }
    
    
    @objc func manualSegueInfo() {
        // This is the same logic to pass the custom text
        if customView.customTextSwitch.isOn && customView.customTextView.text?.isEmpty ?? true {
            let alertController = UIAlertController(title: "Add a custom string!", message: nil, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                print("Alert controller dismissed")
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true)
        } else {
            // Instantiating storyboard from "Main"
            guard let loremViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoremViewController") as? LoremViewController else { return }
            
            if customView.customTextSwitch.isOn {
                loremViewController.loremText = customView.customTextView.text
            }
            
            present(loremViewController, animated: true)
        }
    }
    
    // XIB no longer exists
    @objc func manualSegueInfoUsingXIB() {
        // This is the same logic to pass the custom text
        if customView.customTextSwitch.isOn && customView.customTextView.text?.isEmpty ?? true {
            let alertController = UIAlertController(title: "Add a custom string!", message: nil, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                print("Alert controller dismissed")
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true)
        } else {
            
            let loremViewController = LoremViewController(nibName: "LoremViewController", bundle: nil)
            
            if customView.customTextSwitch.isOn {
                loremViewController.loremText = customView.customTextView.text
            }
            
            
            // MAKING SAME VALIDATION AND PRESENTATION AGAIN
            present(loremViewController, animated: true)
        }
    }
    
    
    // NOTE - was changed from @IBaction to @objc
    @objc func switchValueChanged(_ sender: UISwitch) {
        // If "Custom text" switch changes (note: tag value was set manually)
        print(sender)
        if sender.tag == 48 {
            customView.customTextView.isEditable = sender.isOn
        } else if sender == customView.pictureTypeSwitch {
            customView.picsButton.setImage(UIImage(systemName: sender.isOn ? "dog.fill" : "cat.fill"), for: .normal)
        }
    }
    
    @objc func picsClickPresentSegue(_ sender: UIButton) {
        // can pass `nibName: nil` since PicturesView and PicturesViewController filenames match!
        let picturesViewController = PicturesViewController(nibName: nil, bundle: nil)
        
        // pass data to the controller
        picturesViewController.pictureType = customView.pictureTypeSwitch.isOn ? .dog : .cat
        picturesViewController.showCaptions = customView.showCaptionSwitch.isOn
        
        // push due to horizontal navigation
        navigationController?.pushViewController(picturesViewController, animated: true)
        
    }
    
    // set @objc to be able to pass this function as "action" param in UIBarButtonItem constructor
    @objc @IBAction func logout(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    // Listen for "Info" Bar button item to mannually open modal
    @IBAction func manuallyPerformInformationSegue(_ sender: UIBarButtonItem) {
        if customView.customTextSwitch.isOn {
            // if no text or text is empty...
            if customView.customTextView.text?.isEmpty ?? true {
                // show an alert
                let alertController = UIAlertController(title: "Add a custom string!", message: nil, preferredStyle: .alert)
                
                let dismissAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    print("Alert controller dismissed")
                }
                //                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
                alertController.addAction(dismissAction)
                present(alertController, animated: true)
                
            } else {
                performSegue(withIdentifier: "tagInformationSegue", sender: self)
            }
        } else {
            performSegue(withIdentifier: "tagInformationSegue", sender: self)
        }
    }
}


// Extension to delegate UITextView and set the text.
extension HomeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxCharacters = 15
        
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet.whitespacesAndNewlines)
        
        // To get number of new characters, we get current count less range plus new text length
        let currentCharacters = textView.text.count - range.length + text.count
        
        let isSubset = CharacterSet(charactersIn: text).isSubset(of: allowedCharacters)
        
        // if user type backspace or his text is within range
        if text == "" || currentCharacters < maxCharacters && isSubset {
            return true
        }
        
        return false
    }
}
