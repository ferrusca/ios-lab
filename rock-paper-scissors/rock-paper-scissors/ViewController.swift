//
//  ViewController.swift
//  rock-paper-scissors
//
//  Created by Jorge Ferrusca_C on 04/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var winValue: UITextField!
    @IBOutlet weak var loseValue: UITextField!
    @IBOutlet weak var scoreToWin: UITextField!
    
    
    var rounds = 2;
    var gameRoundsMode = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.viewWithTag(1)?.isHidden = false
        self.view.viewWithTag(2)?.isHidden = true
        
        roundsLabel.text = "Rounds: 2"
    }
    
    
    @IBAction func segmentedControlToggle(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        let selectedIndex = sender.selectedSegmentIndex + 1
        
        gameRoundsMode = selectedIndex == 1
        
        self.view.viewWithTag(selectedIndex)?.isHidden = false
        self.view.viewWithTag(selectedIndex == 1 ? 2 : 1)?.isHidden = true
        
        validateContinueButton()
    }
    
    private func validateContinueButton() {
        if let nameText = nameTextInput?.text {
            continueButton.isEnabled = nameText.count > 0 && (
                (gameRoundsMode == true && rounds > 0) || true
            )
        } else {
            // No name set, disabled
            continueButton.isEnabled = false
        }
    }
    
    @IBAction func characterTyped() {
        validateContinueButton()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        rounds = Int(floor(sender.value * 10 / 2))
        roundsLabel.text = "Rounds: \(rounds)"
//        startButton.isEnabled = rounds != 0 && nameTextInput.text.
    }
    
    @IBAction func gameSegue(_ sender: UIButton) {
        let gameViewController = GameViewController(nibName: nil, bundle: nil)
        
        // push to perform horizontal navigation
        navigationController?.pushViewController(gameViewController, animated: true)
        
    }


}

