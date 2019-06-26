//
//  CalculatorViewController.swift
//  MyCalculator
//
//  Created by Alex on 6/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import RPN

class CalculatorViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()
    
    var calculator = Calculator() {
        didSet {
            if let value = calculator.topValue {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        // Push value from accumulator to stack
        if let value = digitAccumulator.value() {
            calculator.push(value)
        }
        
        // Clear digits to get ready for next operation
        digitAccumulator.clear()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .divide)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .multiply)
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .subtract)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .add)
    }
    
    // MARK: - Operations
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        calculator.clearStack()
        digitAccumulator.clear()
        
        return true
    }

}
