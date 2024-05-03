import Foundation

/// You can ignore line 6, asume that the constant ``myCities`` will contain an **Set of Strings**
/// For testing locally you can comment line 6 and remove the `//` from line 7, just remember to comment line 7 and remove the `//` from line 6 before submitting your code

let myCities: Set = Set(CommandLine.arguments.dropFirst())
//let myCities: Set = ["Atlanta", "Chicago", "Jacksonville", "New York", "Denver"]

let yourCities: Set = ["Chicago", "Denver", "Jacksonville"]


// print true if the myCities Set contains all the cities in yourCities and false otherwise
print(myCities.isSuperset(of: yourCities))


