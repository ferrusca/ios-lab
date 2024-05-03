import Foundation
// Extension
//Can be used to:
// - add computed properties
// - add new initializers
// - add protocol conformance
// - add new methods
// - add embedded types


extension Double {
    var squared: Double { self * self }
}

let sideLength: Double = 2.22

let squaredLength = sideLength.squared
print(squaredLength)


struct Car {
    let maker: String
    let model: String
    let year: Int
    var fuelLevel: Double {
        willSet {
            precondition(newValue >= 0 && newValue <= 1.0, "New value must be between 0 and 1")
        }
    }
}

// ----- INITIALIZERS -----

// Adding an extension for the car (instead of passing the protocol like `struct Car: CustomStringConvertible`
// MARK - Conformance to CustomStringConvertible
// In an extension, all items are accesible so the access modifiers for a property won't work.
extension Car: CustomStringConvertible {
    var description: String {
        return "My car is: \(maker) - \(model) "
    }
}

// MARK - Create new initializers
// Advantage: Creating an init in an extension preserves the original init that comes from the struct.
extension Car {
    init(maker: String, model: String, year: Int) {
        self.init(maker: maker, model: model, year: year, fuelLevel: 1)
    }
}

// MARK - Embedded types.
extension Car {
    enum Era {
        case Modern, Vintage, Veteran
    }
    
    var era: Era {
        switch year {
        case ...1996: return .Veteran
        case 1897...1919: return .Vintage
        default: return .Modern
        }
    }
}

// Mark - Add new methods for our type
extension Car {
    // structures by default are inmutables. Using `mutating` to bypass
    mutating func emptyFuel(by amount: Double) {
        precondition(amount >= 0 && amount <= 1, "Amount to remove must be between 0 and 1")
        fuelLevel = fuelLevel - amount;
    }
    
    mutating func refillFuel() {
        fuelLevel = 1.0
    }
}

// When passsing values in the constructor, the precondition won't be evaluated.
let firstCar = Car(maker: "Honda", model: "Civic", year: 2017, fuelLevel: 200);
let secondCar = Car(maker: "Toyota", model: "Prius", year: 2017, fuelLevel: 0.5);

// printing car
print(firstCar)
print(firstCar.era)


// Equatable: Swift protocol to compare two items
extension Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        // For us, two cars are equal if they're same year
        return lhs.year == rhs.year
    }
}

print("Are the cars equal?: \(firstCar == secondCar)")

// Adding computed properties in the extenion
extension Int {
    var isEven: Bool  {
        self.isMultiple(of: 2)
    }
    
    var isOdd: Bool {
        !self.isMultiple(of: 2)
    }
}


print(2.isEven)
print(2.isOdd)


// Generics

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        
        return items.popLast()
    }
    
    // Adding a generic
    func myMap<U>(_ transformer: (Element) -> U) -> Stack<U> {
        var transformedItems = [U]()
        
        for item in items {
            transformedItems.append(transformer(item))
        }
        
        return Stack<U>(items: transformedItems)
        
        // TODO: check if works
//        return items.map(transformer)
    }
}

var intStack = Stack<String>()
intStack.push("Jorge")
intStack.push("Luis")
intStack.push("Ferrusca")

print(intStack.pop())
print(intStack.pop())


print(intStack.myMap {
    item in "\(item) mapped"
})

// `myMap` did not mutate Stack preserving its original values

print(intStack)

func myCustomMap<T, U>(_ items: [T], _ transformer: (T) -> U) -> [U] {
    var result = Array<U>()
    
    for item in items {
        result.append(transformer(item))
    }
    
    return result
}

let newArray: [Int] = myCustomMap(["one", "word", "a"]) {
    word in word.count
}

print(newArray)


// Using constrainted typpes

func checkIfDescMatch<T: CustomStringConvertible, U: CustomStringConvertible>(_ first: T, _ second: U) -> Bool {
    return first.description == second.description
}

checkIfDescMatch(1, "1")
checkIfDescMatch(1, 1)


// Implementing iterator protocol
// Rule: need to return the same associated type in the next() function
//protocol IteratorProtocol {
//    associatedType Element
//
//    mutating func next() -> Element?
//}

//struct StackIterator<T>: IteratorProtocol {
//    typealias Element = T
//    
//    var stack: Stack<T>
//    
//    mutating func next() -> Element? {
//        return stack.pop()
//    }
//}

// Aboves simplified

struct StackIterator<T>: IteratorProtocol {
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}


var myStack = Stack<Int>()

myStack.push(10)
myStack.push(35)
myStack.push(50)

var myStackIterator = myStackIterator(stack: myStack)

// Using next to get the elements from the stack
while let value = myStackIterator.next() {
    print(value)
}


// Another important protocol is `Sequence`
//
//protocol Sequence {
//    associatedType Iterator: IteratorProtocol;
//    associatedType Element where Element == Iterator.Element;
//    
//    func makeIterator() -> Iterator
//}


// transforming stack in sequence
struct SequencedStack<Element>: Sequence {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        
        return items.popLast()
    }
    
    // Adding a generic
    func myMap<U>(_ transformer: (Element) -> U) -> Stack<U> {
        var transformedItems = [U]()
        
        for item in items {
            transformedItems.append(transformer(item))
        }
        
        return Stack<U>(items: transformedItems)
        
        // TODO: check if works
//        return items.map(transformer)
    }
    
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
}

var mySequencedStack = SequencedStack<Int>()

mySequencedStack.push(10)
mySequencedStack.push(35)
mySequencedStack.push(50)

//now that our stack is a sequence, we can use for to iterate over it
for val in mySequencedStack {
    print("\(val)")
}
