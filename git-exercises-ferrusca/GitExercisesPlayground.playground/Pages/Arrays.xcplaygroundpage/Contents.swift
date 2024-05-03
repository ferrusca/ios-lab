import Foundation

/// You can ignore line 6, asume that the constant ``myTodoList`` will contain an **Array of Strings**
/// For testing locally you can comment line 6 and remove the `//` from line 7, just remember to comment line 7 and remove the `//` from line 6 before submitting your code

let myTodoList: [String] = CommandLine.arguments.count == 1 ? [] : CommandLine.arguments
//let myTodoList: [String] = ["go to the supermarket", "buy a new iPhone", "watch some Apple TV+ shows"]

// print true if the array is empty and false if it contains at least one element
print(myTodoList.isEmpty)
