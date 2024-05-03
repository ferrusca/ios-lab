import Foundation

/// You can ignore line 8, asume that the constant ``numbers`` will contain an **Array of Integers**
/// For testing locally you can comment line 8 and remove the `//` from line 9

/// **Remember to comment line 9 and remove the `//` from line 8 before submitting your code**

let numbers: [Int] = Array(CommandLine.arguments.dropFirst()).map { Int($0)! }
//let numbers = [1, 2, 3, 4, 5, 6]

// Sum using filter, map and reduce
let oddNumbers = numbers.filter { $0 % 2 != 0 }
let squaredNumbers = oddNumbers.map({ number in number * number })
let aggregate = squaredNumbers.reduce(0) { (total, item) in
    return total + item
}

// Print the resulting value
print(aggregate)


