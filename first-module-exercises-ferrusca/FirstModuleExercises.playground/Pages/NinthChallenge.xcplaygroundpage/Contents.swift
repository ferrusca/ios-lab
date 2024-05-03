//: [Previous](@previous)

import Foundation

struct Person {
    let name: String
    let age: Int
}

func findAgeDifference(for family: [Person]) -> (oldest: Int, youngest: Int, ageDifference: Int) {
    guard let oldest = family.max(by: { $0.age < $1.age }),
          let youngest = family.max(by: { $0.age > $1.age })
    else { fatalError("Unable to get the youngest or oldest person") }
  
    let ageDifference = oldest.age - youngest.age
    
    return (oldest: oldest.age, youngest: youngest.age, ageDifference: ageDifference)
}

let son = Person(name: "Juan", age: 19)
let daughter = Person(name: "Maria", age: 12)
let mother = Person(name: "Benita", age: 60)
let father = Person(name: "Camilo", age: 58)

let family = [daughter, son, mother, daughter]

print(findAgeDifference(for: family))
// (oldest: 60, youngest: 12, ageDifference: 48)
