class CalculatorModel {
    var display = "0"
    var firstValue = 0.0
    var operation: String?
    
    var dotCheck = false
    var typingCheck = false
    var displayValue: Double {
        get {
            Double(display)!
        }
        set {
            display = (newValue.isInt() ? String(Int(newValue)) : String(newValue))
        }
    }
    
    func touchDigit(_ digit: String) {
        if !typingCheck{
            display = digit
            if digit != "0" {
                typingCheck = true
            }
        } else {
            display += digit
        }
    }

    func touchDot(){
        if !dotCheck{
            if !typingCheck{
                display = "0"
            }
            display += "."
            typingCheck = true
            dotCheck = true
        }
    }
    
    func setOperation(_ newOperation: String) {
        if let _ = operation { // 이미 operation 있다면
            calculate()
            operation = newOperation
        } else {
            firstValue = displayValue
            operation = newOperation
            typingCheck = false
            dotCheck = false
        }
    }
    
    func calculate() {
        if let oper = operation {
            switch oper {
            case "+": firstValue += displayValue
            case "−": firstValue -= displayValue
            case "×": firstValue *= displayValue
            case "÷": if displayValue != 0.0 { firstValue /= displayValue }
            default: break
            }
            displayValue = firstValue
        }
        typingCheck = false
        operation = nil
    }
    
    func toggleSign() {
        if display != "0" {
            displayValue *= -1
        }
    }
    
    func calculatePercentage() {
        if display != "0" {
            displayValue *= 0.01
        }
    }
    
    func clear() {
        display = "0"
        typingCheck = false
        operation = nil
        dotCheck = false
    }
}

extension Double {
    func isInt() -> Bool {
        return self == Double(Int(self))
    }
}
