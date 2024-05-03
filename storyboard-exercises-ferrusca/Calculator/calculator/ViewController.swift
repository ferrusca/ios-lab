//
//  ViewController.swift
//  calculator
//
//  Created by Jorge Ferrusca_C on 16/03/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var plusMinus: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    let DECIMAL_POINT_TAG = 10
    let AC_TAG = 11
    let ADD_TAG = 12
    let SUBS_TAG = 13
    let MULTIPLY_TAG = 14
    let DIVIDE_TAG = 15
    
    var currentOperator: String!
    var currentOperand: String = "0"
    var firstOperand: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = currentOperand
    }
    
    @IBAction func operandTap(sender: UIButton) {
        let digitTapped = sender.tag
        
        // automatically add decimal point (only if doesn't exists)
        if (sender.tag == DECIMAL_POINT_TAG) {
            if (!currentOperand.contains(/\./)) {
                currentOperand = "\(currentOperand)."
            }
        } else {
            currentOperand = currentOperand == "0" ? "\(digitTapped)" : "\(currentOperand)\(digitTapped)"
        }
        
        resultLabel.text = currentOperand;
    }
    
    @IBAction func operatorTap(sender: UIButton) {
        // TODO: handle digit when it's pressed after performing operation.
        if (sender.tag == AC_TAG) {
            // if AC button was already pressed, clear calculator state
            if (currentOperand == "0") {
                firstOperand = 0
                currentOperator = ""
            }
            currentOperand = "0"
            resultLabel.text = currentOperand
            return
        }
        
        if firstOperand != nil {
            performOperation()
        }
        firstOperand = (resultLabel != nil) ? Double(resultLabel.text ?? "0") : 0
        currentOperand = "0"
        
        switch sender.tag {
        case SUBS_TAG:
            currentOperator = "-"
        case ADD_TAG:
            currentOperator = "+"
        case MULTIPLY_TAG:
            currentOperator = "x"
        case DIVIDE_TAG:
            currentOperator = "/"
        default: fatalError("Operator not recognized")
        }
    }
    
    @IBAction func performOperation() {
        var result: Double;
        switch currentOperator {
        case "+":
            result = firstOperand + Double(currentOperand)!
        case "-":
            result = firstOperand - Double(currentOperand)!
        case "x":
            result = firstOperand * Double(currentOperand)!
        case "/":
            result = firstOperand / Double(currentOperand)!
        default: print("Operador doesn't exist. Skipping")
            return
        }
        resultLabel.text = result.remainder(dividingBy: 1) == 0 ? "\(Int(result))" : "\(result)"
    }


}

