import Foundation

/// You can ignore line 8, asume that the constant ``numbers`` will contain an **Array of Integers**
/// For testing locally you can comment line 8 and remove the `//` from line 9

/// **Remember to comment line 9 and remove the `//` from line 8 before submitting your code**

var numbers: [Int] = Array(CommandLine.arguments.dropFirst()).map { Int($0)! }
//var numbers: [Int] = [6, 3, 2, 9, 21, 44]


// Print the sorted array
numbers.sort()
print(numbers)

