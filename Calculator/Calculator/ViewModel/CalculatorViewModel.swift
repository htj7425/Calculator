//
//  CalculatorVM.swift
//  Calculator
//
//  Created by Taejun Ha on 10/29/23.
//

import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var display = "0"
    
    private var calculatorModel: CalculatorModel = CalculatorModel()
    
    private func updateDisplay(){
        display = calculatorModel.display
    }
    
    func touchDigit(_ digit: String) {
        calculatorModel.touchDigit(digit)
        updateDisplay()
    }
    
    func setOperation(_ newOperation: String) {
        calculatorModel.setOperation(newOperation)
        updateDisplay()
    }
    
    func equalOperation() {
        calculatorModel.calculate()
        updateDisplay()
    }
    
    func clear() {
        calculatorModel.clear()
        updateDisplay()
    }
        
    func touchDot() {
        calculatorModel.touchDot()
        updateDisplay()
    }
    
    func toggleSign() {
        calculatorModel.toggleSign()
        updateDisplay()
    }
    
    func calculatePercentage() {
        calculatorModel.calculatePercentage()
        updateDisplay()
    }
}
