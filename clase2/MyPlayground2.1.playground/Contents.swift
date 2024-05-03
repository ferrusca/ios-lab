import Foundation

var greeting = "Hello, playground"

// Functions

// - Variadic parameters

// lhs - left hand side operator
func add(lhs: Int, rhs: Int) -> Int {
    // implicit return
    lhs + rhs
}

add(lhs: 2, rhs: 29)

// Proposition label always goes to the end
func printWelcomeMessage(course: String, to name: String) {
    print("Welcome to \(name). This course is \(course)")
}

func printWelcomeMessage(course: String, to1 name: String) {
    print("Welcome1 to \(name). This course is \(course)")
}

func printWelcomeMessage(course: String, name: String) {
    print("Welcome2 to \(name). This course is \(course)")
}

// Method's arity.
printWelcomeMessage(course: "UNAM-cert", to1: "Jorge");
printWelcomeMessage(course: "UNAM-cert", name: "Jorge");


// In-out parameters
var error = "The process failed: "

func appendErrorCode(_ code: Int, toErrorString errorString: inout String) {
    errorString += "\(code)."
}

print(error)
// note the ampersand due to the **inout** param
appendErrorCode(418, toErrorString: &error)
print(error)

// This doesn't work
//let _ = "foo"
//print(_)


// Nested functions and scope
func triangleArea(base: Double, height: Double) -> Double {
    let rectangleArea = base * height
    
    func divide() -> Double {
        let rectangleArea = 3.1416
        print(rectangleArea)
        
        return rectangleArea / 2
    }
    
    print(rectangleArea)
    return divide()
}

triangleArea(base: 20, height: 1)

// Multiple return
func sortedEvenOddNumbers(_ unsorted: Array<Int>) -> (even: Array<Int>, odd: Array<Int>) {
    var even = [Int]()
    var odd = [Int]()
    
    for number in unsorted {
        // % stands for reminder (not module).
        number % 2 == 0 ? even.append(number) : odd.append(number)
        
    }
    
    return (even: even, odd: odd)
}

print(sortedEvenOddNumbers([1, 44, 13, 78, 75, 65, 95, 2]))


// Optional returning function
func grabMiddleName(fromFullName: (String, String?, String)) -> String? {
    return fromFullName.1;
}

// Ways to unwrap optional

let myName: (String, String?, String) = ("Jorge", nil, "Ferrusca")

let middleName = grabMiddleName(fromFullName: myName)

// Option 1
print(middleName ?? "No existe 2do nombre")
// Option 2

if let middleName = grabMiddleName(fromFullName: myName) {
    print("Sí existe 2do nombre!")
}

// Option 3. Were forcing to unwrap an optional so it will throw error
//print(grabMiddleName(fromFullName: myName)!)


func foo(fromFullName name: (first: String, middle: String?, last: String)) -> String {
    if let middle = name.middle {
        return "Yes, \(middle)"
    }
    
    return "no name"
    
//     or working with guards
    
//    guard let middle = name.middle else {
//        return "no name"
//    }
//    
//    return "Yes, \(middle) "
}

print(foo(fromFullName: ("Jorge", "Luis", "Ferrusca")))

// Clousures

let myConst = foo

myConst(myName)

// sort clousure
[10, 1, 2, 7].sorted(by: { (lhs: Int, rhs: Int) -> Bool in
    return lhs < rhs
})

// sort clousure (type inference and argument inference $
let sorted = [10, 1, 2, 7].sorted(by: {
    $0 < $1
})

print(sorted)

// sort even smaller
//
// Function knows that it will receive two args.
// Use $ notation to indicate the number of the argument
[2,1].sorted { $0 < $1 }
// Even smaller
[2,1].sorted(by: <)


// When a clousure its the last argument in a function you can remove the parameter name. Examples:
[2,1,3].sorted { lhs, rhs in
    return lhs < rhs
}

func doAwesomeTask(on: String, inputParam: (() -> ()), then completition: (() -> ())) {}
//doAwesomeTask(on: "on parameter"') { } then: { }

let defaultFormatter: (Double) -> String = { "\($0)" }

func format(numbers: [Double], using formatter: (Double) -> String = defaultFormatter) -> [String] {
    var result = [String]()
    
    for number in numbers {
        let transformed = formatter(number)
        result.append(transformed)
    }
    
    return result;
}

let rounder: (Double) -> String = { (number: Double) -> String in
    let rounded = number.rounded()
    let justInteger = Int(rounded);
    
    return "\(justInteger)"
}

// Average attending of a determinate event
let volunteerAverages = [10.7, 4,3, 7.6, 8.4]

let atendees = format(numbers: volunteerAverages, using: rounder)
print(atendees)

let atendeesWithDefaultformatter = format(numbers: volunteerAverages)
print(atendeesWithDefaultformatter)


// Clousures

//Functional programming capabilities
//* First class function
//* Pure NSPointerFunctionsInmutability
// Strong typed

// map
let roundedAverages = volunteerAverages.map({ (average: Double) -> Int in
        return Int(average)
})
// or
let roundedAverages2 = volunteerAverages.map({ Int($0) })
// or
let roundedAverages3 = volunteerAverages.map { Int($0) }

let lessThanTenVolunteers = volunteerAverages.filter { $0 < 10 }
// or
let lessThanTenVolunteers2 = volunteerAverages.filter({ count in count < 10 })

print(lessThanTenVolunteers)
print(lessThanTenVolunteers2)

// The parameter within reduce() is the initial value. This is a TRAILING CLOUSURE
let total = [3, 5, 6].reduce(0) { acc, element in acc + element }
                             
print(total)
