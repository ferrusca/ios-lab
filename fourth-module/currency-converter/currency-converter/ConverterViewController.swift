//
//  ConverterViewController.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import UIKit

class ConverterViewController: UIViewController {
    @IBOutlet weak var sourcePickerView: UIPickerView!
    @IBOutlet weak var targetPickerView: UIPickerView!
    @IBOutlet weak var amountTextInput: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var arrowImageview: UIImageView!
    let currencyConversionModel = CurrencyConversionModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeArrowIconGestureRecognizer()
        try? currencyConversionModel.getAll()
        
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        targetPickerView.delegate = self
        targetPickerView.dataSource = self
        
        sourcePickerView.reloadAllComponents()
        targetPickerView.reloadAllComponents()
    }
    
    private func initializeArrowIconGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(toggleArrow(tapGestureRecognizer:))
        )
        arrowImageview.isUserInteractionEnabled = true
        arrowImageview.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func toggleArrow(tapGestureRecognizer: UITapGestureRecognizer) {
        arrowImageview.isHighlighted = !arrowImageview.isHighlighted
        
        // inverting picker values
        let sourceIndex = targetPickerView.selectedRow(inComponent: 0)
        let targetIndex = sourcePickerView.selectedRow(inComponent: 0)
        
        let sourceCountryCode = currencyConversionModel.getCountryCodeList()[sourceIndex]
        let targetCountryCode = currencyConversionModel.getCountryCodeList()[targetIndex]
            
        realConversion(sourceCountryCode: sourceCountryCode, targetCountryCode: targetCountryCode)
    
    }
    
    
    @IBAction func convert(_ sender: UIButton) {
        var sourceIndex = 0
        var targetIndex = 0
        
        if !arrowImageview.isHighlighted {
            sourceIndex = sourcePickerView.selectedRow(inComponent: 0)
            targetIndex = targetPickerView.selectedRow(inComponent: 0)
        } else {
            sourceIndex = targetPickerView.selectedRow(inComponent: 0)
            targetIndex = sourcePickerView.selectedRow(inComponent: 0)
        }
        
        
        
        let sourceCountryCode = currencyConversionModel.getCountryCodeList()[sourceIndex]
        let targetCountryCode = currencyConversionModel.getCountryCodeList()[targetIndex]
        
        realConversion(sourceCountryCode: sourceCountryCode, targetCountryCode: targetCountryCode)
           
    }
    
    
    func realConversion(sourceCountryCode: String, targetCountryCode: String) {
        guard let amountText = amountTextInput.text, let amount = Double(amountText) else {
            currencyLabel.text = "Error. Enter a valid amount"
            return
        }
        
        let tasaCambio = currencyConversionModel.getCurrencyConversion(sourceCountryCode: sourceCountryCode, targetCountryCode: targetCountryCode)
           
        let result = amount * tasaCambio
        currencyLabel.text = String(format: "%.2f", result)
    }

}

extension ConverterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyConversionModel.getCountryCodeList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("foo")
        print(currencyConversionModel.getCountryCodeList()[row])
        return currencyConversionModel.getCountryCodeList()[row]
    }
}
