//
//  ViewController.swift
//  rgb-colors
//
//  Created by Jorge Ferrusca_C on 06/04/24.
//

import UIKit

enum SelectedSliderTag: Int {
    case First
    case Second
    case Third
}


class ViewController: UIViewController {
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetRGBValues()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let newColorValue = sender.value * 255;
        switch sender.tag {
            // Red case
        case SelectedSliderTag.First.rawValue:
            self.view.backgroundColor = UIColor(red: CGFloat(sender.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
            redLabel.text = "Red \(newColorValue)"
            
            // Green case
        case SelectedSliderTag.Second.rawValue:
            self.view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(sender.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
            greenLabel.text = "Green \(newColorValue)"
            
            // Blue case
        case SelectedSliderTag.Third.rawValue:
            self.view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(sender.value), alpha: 1.0)
            blueLabel.text = "Blue \(newColorValue)"
        default: print("Unknown slider option")
        }
        
        print(sender.value * 255)
    }
    
    @IBAction func resetButtonClick() {
        resetRGBValues()
    }
    
    func resetRGBValues() {
        redLabel.text = "Red 255"
        greenLabel.text = "Green 255"
        blueLabel.text = "Blue 255"
        redSlider.setValue(1.0, animated: true)
        greenSlider.setValue(1.0, animated: true)
        blueSlider.setValue(1.0, animated: true)
        self.view.backgroundColor = .white
    }


}

