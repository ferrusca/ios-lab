//: [Previous](@previous)

import Foundation

//: [Next](@next)

var animal = "dog"

guard animal == "dog" else {
    fatalError("Error thrown from guard!")
}

if animal == "dog" {
    
} else {
    fatalError("Not a dog")
}

let grade = 11

switch (grade) {
    case _ where grade < 10:
        1 + 1
        print("Not excellent")
    
    case 10...:
            print("More than ten")
    default: break
}



// Ejercicio en clase: Plano cartesiano

let coord = (-500, -1)

switch coord {
    case (0, 0): print("\(coord) está en el origen")
    case (_, 0): print("\(coord) sobre el eje X")
    case (0, _): print("\(coord) sobre el eje Y")
    case let (x, y) where x > 0 && y > 0: print("\(coord) en cuadante I")
    case let (x, y) where x < 0 && y > 0: print("\(coord) en cuadante II")
    case let (x, y) where x < 0 && y < 0: print("\(coord) en cuadante III")
    case let (x, y) where x > 0 && y < 0: print("\(coord) en cuadante IV")
    default: print("Unknown option")
}

// Ciclos

for index in 0...4 {
    print(index)
}

print("========")

let intervalsUpToLast = stride(from: 0, to: 31, by: 5);
// stride through INCLUDES the limit
let intervalsWithThrough = stride(from: 0, through: 31, by: 5)

for number in intervalsUpToLast {
    print(number)
}

print("========")

for number in intervalsWithThrough {
    print(number)
}

// NOTE: this does not preserve its order when its loaded in memory.
let dictionary = ["a": 1, "b":2, "c": 5, "d": 88]


print(type(of: dictionary))

for (key, value) in dictionary {
    print(key, value)
}

for item in dictionary {
    print("key: \(item.key) - value: \(item.value)")
}

// Filtering values in dicitonary
for (key, value) in dictionary where value == 88 {
    print("Key with value 88 is \(key)")
}


let names: Set<String> = ["Dean", "Sam", "Bobby", "Ellen"];

for (index, personName) in names.enumerated() {
    print(index)
    if (index % 2 != 0) {
        continue
    }
    print(personName)
}

// From zero to sixty
for value in stride(from: 0, through: 60, by: 15) {
    print(value)
}

let s = stride(from: 5, through: 1, by: -1)
print(s.contains(3))

// While
var counter = 2
while 1...5 ~= counter {
    print(counter)
    counter += 1
    print("")
}

var counter2 = -1
// do while
repeat {
    print("this always gets executed")
} while 1...5 ~= counter2



// Ejercicio: Serpientes y escaleras

var currentPosition = 0;
var dice: Int = 0
let maxPosition = 24
let jumps = [2: 8, 5: 11, 8 :9, 9: 2, 13: -10, 18: -11 ,21: -11, 23: -8];

while currentPosition < maxPosition {
    print("\nEstas en la casilla: \(currentPosition)\nTirando dado...")
    sleep(2)
    dice = Int.random(in: 1...6)
    print("El valor del dado es \(dice)\nAvanzando...")
    currentPosition += dice
    print("Llegaste a la posicion \(currentPosition > maxPosition ? maxPosition : currentPosition)")
    if let jump = jumps[currentPosition] {
        currentPosition += jump
        print("Caiste en \(jump > 0 ? "Escalera" : "Serpiente")!, tu nueva posicion es \(currentPosition)")
    }
}
          

print("Ganaste!")
