enum OperationType {
    case addition, substraction, multiplication, division
}

func operation (_ operationType: OperationType, firstNumber lhs: Double, secondNumber rhs: Double) -> Double {
    let result: Double;
    switch operationType {
    case .addition: return lhs + rhs;
    case .substraction: return lhs - rhs;
    case .multiplication: return lhs * rhs;
    case .division:
        if rhs == 0 {
            fatalError("Cannot divide by zero")
        }
        return lhs / rhs;
   }
}

print(operation(.addition, firstNumber: 7, secondNumber: 12))
print(operation(.substraction, firstNumber: 7, secondNumber: 3))
print(operation(.multiplication, firstNumber: 7, secondNumber: 3))
print(operation(.division, firstNumber: 125, secondNumber: 5))
