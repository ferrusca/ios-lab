[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Uxv1Rf7E)
# First Module Exercises

## First challenge
Create a function that receives an enumerator as a parameter with the following options: `.addition`, `.subtraction`, `.multiplication` , `.division` and 2 numbers. 

Print the operation according to the selected enumerator.

```swift
operation(.addition, firstNumber: 3, secondNumber: 4) 
// 7 
```


## Second challenge
Create a function that receives an integer and prints whether the value is positive, negative or zero.

Print the result to the console.

```swift
comparison(number: -1)
// negative 
```


## Third challenge
Create a function that receives an integer and prints that number multiplied from 1 to 10.

```swift
multiply(number: 5)
// 5x1 = 5
// 5x2 = 10
// 5x3 = 15
// 5x4 =20
// 5x5 = 25
// 5x6 = 30
// 5x7 = 35
// 5x8 = 40
// 5x9 = 45
// 5x10 = 50
```

## Fourth challenge
Make a function that receives a `string` that simulates a password and returns `true` if they comply with the rules or `false` if they do not.

Rules:
- Min 6 characters
- Contains a capital letter
- Contain a number
- Contain a point

```swift
login(password: "pass")
// false
```

## Fifth challenge
Make a function that receives an `optional string` and prints that same string without the optional value. If the value is `nil` print "empty value". 

```swift
let testString: String? = "Hello world"
optionals(string: testString)
// “Hello world”
```

## Sixth challenge
 Given an `optional string`, print "It's empty! You ripped me off!" when it's `nil`, "Thanks for my cat Schrödinger!" if input is "🐈" and "This ain't a cat!" when none of the others.
 
```swift
receiveBox(with: "🐈")
// "Thanks for my cat Schrödinger!"
 
receiveBox(with: nil)
// "It's empty! You ripped me off!"

receiveBox(with: "lol")
// "This ain't a cat!"
```


## Seventh challenge
Transform the snakes and ladders game code into a function that receives an `array` of numbers, which will represent dice rolls.
Return and print the current position after iterating over all members of the `array`. 
Keep the same snakes/ladders values and positions.

```swift
let rolls = [2,3,5,6,5,4]
game(diceRolls: rolls)
// 24
```

## Eigth challenge
Implement the _Sieve of Eratosthenes_ algorithm in Swift from the provided unit tests. Return and print the resulting `array` containing only the prime numbers within the range.

- The only parameter is the max number.
- 0 and 1 are not prime numbers.
- The next available number is marked as prime but the next multiples up to the max number are not.
- Find the next prime number and repeat the previous step until reaching max number.

```swift
PrimeCalculator.calculate(upTo: 10)
// [2,3,5,7]

PrimeCalculator.calculate(upTo: 50)
// [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]

PrimeCalculator.calculate(upTo: 85)
// [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83]
```

## Ninth challenge
Given an array of `people`, find the youngest, the oldest and the difference in age between them, and return their respective ages and the age difference.

```swift
struct Person {
    let name: String
    let age: Int
}

let son = Person(name: "Juan", age: 19)
let daughter = Person(name: "Maria", age: 12)
let mother = Person(name: "Benita", age: 60)
let father = Person(name: "Camilo", age: 58)

let family = [daughter, son, mother, daughter]

findAgeDifference(for: family)
// (oldest: 60, youngest: 12, ageDifference: 48)

```

## Tenth challenge
Write a closure that takes an `array` of optional strings and returns a new string that is the concatenation of all the strings in the array. Remember to use the methods `map`, `filter` and `reduce` to find the solution.

```swift
let someStrings: [String?] = ["This", "is", nil, "not", nil, "a", "drill", nil, "!"]
// This is not a drill!
```
