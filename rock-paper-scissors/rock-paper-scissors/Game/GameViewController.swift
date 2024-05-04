//
//  GameViewController.swift
//  rock-paper-scissors
//
//  Created by Jorge Ferrusca_C on 04/05/24.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var opponentImageview: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var userSelectionLabel: UILabel!
    @IBOutlet weak var opponentSelectionLabel: UILabel!
    
    let emojisMap = ["rock": "dot.circle.fill", "scissors": "scissors.circle.fill", "paper": "paperplane.fill"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func getOpponentValue() -> String {
//        var iterator = 1.0
//        while (iterator < 1000) {
        let randomNumber = Int.random(in: 0 ... 2)
        print(randomNumber)
        if let key = randomNumber == 0 ? "rock" : randomNumber == 1 ? "scissors" : "paper" {
            opponentImageview.image = UIImage(systemName: emojisMap[key]!)
            return key
        }
        
        return "rock"
    }
    
    private func calculateWinner(userValue: String, _ opponentValue: String) {
        var label = "Result"
        if userValue == opponentValue {
            resultLabel.text = "\(label): Draw"
            return
        }
        
        if userValue == "rock" {
            label = "\(label): \(opponentValue == "paper" ? "You lost" : "You won")"
        } else if userValue == "scissors" {
            label = "\(label): \(opponentValue == "rock" ? "You lost" : "You won")"
        } else if userValue == "paper" {
            label = "\(label): \(opponentValue == "scissors" ? "You lost" : "You won")"
        }
        
        resultLabel.text = label
    }
    
    @IBAction func pickWeapon(_ sender: UIButton) -> Void {
        if let buttonTitle = sender.titleLabel?.text {
            userImageView.image = UIImage(systemName: emojisMap[buttonTitle.lowercased()]!)
            userSelectionLabel.text = "Your selection: \(buttonTitle)"
            let opponentValue = getOpponentValue()
            opponentSelectionLabel.text = "Opponent selection: \(opponentValue)"
            calculateWinner(userValue: buttonTitle.lowercased(), opponentValue)
            
        }
    }

}
