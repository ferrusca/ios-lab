import Foundation

/// You can ignore line 8, asume that the constant ``groceryList`` will contain an **Array of Strings**
/// For testing locally you can comment line 8 and remove the `//` from line 9

/// **Remember to comment line 9 and remove the `//` from line 8 before submitting your code**

//let groceryList: [String] = Array(CommandLine.arguments.dropFirst())
let groceryList: [String] = ["green beans", "milk", "black beans", "pinto beans", "apples"]


func siftBeans(fromGroceryList groceries: Array<String>) -> (beans: [String], otherGroceries: [String]) {
    var beans = Array<String>()
    var nonBeans = Array<String>()
    
    for grocery in groceries {
        // condition can also be grocery.hasSuffix("beans")
        grocery.ranges(of: /.*beans$/).count > 0 ? beans.append(grocery) : nonBeans.append(grocery)
    }
    
    return (beans: beans, otherGroceries: nonBeans)
}

let result = siftBeans(fromGroceryList: groceryList)

// Print the array of beans
print(result.beans)

// Print the array of other groceries
print(result.otherGroceries)

