import Foundation

/// You can ignore lines 8 to 17, asume that the constant ``name``  contains a **Named Tuple of Strings**
/// For testing locally you can comment lines 8 to 17 and remove the `//` from line 19

/// **Remember to comment line 17 and remove the `//` from line 8 to 17 before submitting your code**

//let name: (first: String, middle: String?, last: String)
//if CommandLine.arguments.count > 3 {
//    name.first = CommandLine.arguments[1]
//    name.middle = CommandLine.arguments[2]
//    name.last = CommandLine.arguments[3]
//} else {
//    name.first = CommandLine.arguments[1]
//    name.middle = nil
//    name.last = CommandLine.arguments[2]
//}

let name = (first: "Alois", middle: "Afpoeowefjewojfewo", last: "Chaz")


func greetByMiddleName(to name: (first: String, middle: String?, last: String)) -> Void {
//    guard let middle = name.middle, middle.count > 10, let firstMatch = middle.firstMatch(of: /./)?.first else {
    guard let middle = name.middle, middle.count > 10, let firstMatch = middle.ranges(of: /./).lowerBound else {
        return print("Hey there!")
    }
    print("Hey, \(name.first) \(firstMatch). \(name.last)")
    
}

// print the greeting
greetByMiddleName(to: name)

