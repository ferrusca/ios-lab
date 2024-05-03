import UIKit

// Optionals

var landline: String? = nil;
var landline3: String? = nil;

// equivalent to `if let landline = landline {...}`
if let landline {
    print(landline)
    // Not valid, internal landline: landline = "hola"
}

landline = "adios"

guard let landline2 = landline else { fatalError() }

print(landline)
print(landline!)
print(landline3 ?? "no value for landline3")
print(landline3)
print(landline != nil ? landline! : "no existe")


// First class citizens

class Vehicle {
    // Stored properties
    let brand: String;
    var owner: String?
    let wheels: Int?;
    var regNumber: String?
    
    // Computed properties (they're always var)
    var type: String {
        return wheels! > 0 ? "land" : "other"
    }
    
    var registration: (name: String, serialNumber: String)? {
        get {
            // Verifying owner and serialNumber exist
            if let owner = owner, let regNumber {
                return (owner, regNumber)
            }
            return nil
        }
        
        set(newRegistration) {
            if let newRegistration {
                owner = newRegistration.name
                regNumber = newRegistration.serialNumber
            }
        }
    }
    
    func move() {
        print("moving from parent...")
    }
    
    func stop() {
        print("stopping from parent...")
    }
    
    init(brand: String, wheels: Int? = 4) {
        self.brand = brand
        // Mandatory assignation since self.wheels is "let" type
        self.wheels = wheels
    }
}

// Instanciating
let bike = Vehicle(brand: "Honda")
bike.owner
bike.owner = "John doe"
bike.owner
bike.type


// Inheritance
class Car: Vehicle {
    // when overriding, the method must keep the same function signature.
    override var type: String {
        return "It's a car"
    }
    
    // Overriding methods
    override func move() {
        print("My car moves...")
    }
    
    override func stop() {
        print("My car is about to stop!")
        super.stop()
    }
    
    convenience init(foo: String) {
        self.init(brand: "MiMarca", wheels:5)
    }
    
    convenience init() {
        self.init(foo: "bar")
    }
}

let myAudi = Car(brand: "Audi")
myAudi.move()
myAudi.stop()


// Estructuras

struct Dog {
    // stored properties
    // let name: String
    
    var isAdopted: Bool
    
    // stored properties with observers (always var)
    // NOTE: computed properties don't have observers
    var name: String {
        willSet {
            print("Value coming: \(newValue), original name is \(name)")
        }
        didSet {
            print("Change done! Now old name is \(oldValue)")
        }
    }
    
    init(adopted name: String) {
        self.name = name
        isAdopted = true
    }
    
    
    // Init with LABELS
    init(bought name: String) {
        isAdopted = false
        self.name = name
    }
}

// structs defined as let cannot change its properties
var kira = Dog(adopted: "Kira")
kira.name = "Torero"

// Assigning an struct to another one results in a copy, not in a reference passed value like classes.
var dog2 = kira
dog2.name = "Kira de nuevo"

print(kira.name)
print(dog2.name)


// static props from an struct are called type props:
struct Water {
    // type property
    static let boilingPoint = 100
}

print(Water.boilingPoint)



// Enums
// Return value is known as _Raw Value_.
enum Animal: String, CaseIterable {
    case mammal
    case bird = "bird has row value"
    case reptile
    
    var spanishValue: String {
        switch self {
        case .bird: return "aves"
        case .mammal: return "mamifero"
        case .reptile: return "reptil"
        }
    }
}

// Declaring types
let type1 = Animal.mammal
let type2: Animal = .reptile
// In this case, type2 doesn't have raw value because the enum has no return type
type2.rawValue

// Rawvalue is an string assigned, example:
Animal.bird.rawValue

// By implementing `CaseIterable` protocol, it has iterable capabilities
Animal.allCases

for type in Animal.allCases {
    print(type.spanishValue)
}


enum Pet: Int {
    case dog = 123
    case cat = 333
    case turtle = 4040
    case parakeet = 3
    
    
    var type: Animal {
        switch self {
        case .dog, .cat: return .mammal
        case .parakeet: return .bird
        case .turtle: return .reptile
        }
    }
    
    // This constructor has questionmark since the name could not be found in the enum
    init?(name: String) {
        switch name {
        case "dog": self.init(rawValue: 123)
        case "cat": self.init(rawValue: 333)
        default: return nil
        }
    }
}

let myPet: Pet = .turtle
print(myPet.rawValue)
print(myPet.type)

Pet(name:"not found")
Pet(name: "dog")


enum ContactMethod {
    case email(String)
    case phone(Int)
    case mail(streetName: String, zipCode: String)
    
    var valor: String {
        switch self {
        case .email(let value): return value
            // casting to string
        case .phone(let value): return "\(value)"
        case .mail(let streetName, let zipCode): return "\(streetName), C.P \(zipCode)"
        }
    }
}

let myEmail = ContactMethod.email("jorge@unam.mx")
let another = ContactMethod.email("anotherMail@unam.mx")
let myPhone = ContactMethod.phone(123333)

myEmail
another

switch myPhone {
case .phone(_): print("It's a phone")
case let .email(valor): print("It's an email")
default: print("Its not a phone")
}



enum AriExpression {
    case number(Double)
    indirect case addition(AriExpression, AriExpression)
    indirect case substraction(AriExpression, AriExpression)
    indirect case multiplication(AriExpression, AriExpression)
    indirect case division(AriExpression, AriExpression)
    
}


///
func eval(expression: AriExpression) -> Double {
    switch expression {
    case let .number(value): return value
    case let .addition(a, b): return eval(expression: a) + eval(expression: b)
    case let .substraction(a, b): return eval(expression: a) - eval(expression: b)
    case let .multiplication(a, b): return eval(expression: a) * eval(expression: b)
    case let .division(a, b): return eval(expression: a) / eval(expression: b)
    }
}


// Ex. Ejecutar (6 + (4*(8-1)))/2.

let result = eval(expression: AriExpression.division(AriExpression.addition(AriExpression.number(6), AriExpression.multiplication(AriExpression.number(4), AriExpression.substraction(AriExpression.number(8), AriExpression.number(1)))), AriExpression.number(2)))

print(result)


