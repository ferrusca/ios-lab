import Foundation

func multiply(number: Int) -> Void {
    for index in 1...10 {
        print("\(number)x\(index) = \(number*index)")
    }
}

multiply(number: 5)
multiply(number: 8)
