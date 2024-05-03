import UIKit

var greeting = "Hello, playground";

var entero: Int = 1;
var pi: Double = 3.1415;

var doubleNumber: Double = 2.3;

var double: Any;

var notInitalized: String;

/* this is a comment */
var boolean: Bool = false;

var decimal: Decimal = 2.3

doubleNumber = 3

/* Cannot assign value of type 'Double' to 'Int' */
// entero = 5.522223

print(doubleNumber)
print(entero)

"2 + 3.12 es \(2+3.12)"
" ".isEmpty


// Arreglos

let diccionario: [String:Int] = ["edad": 100, "peso": 77]
let diccionario2: [String:Bool]
let diccionario3: [String:Bool] = [:]
let array: Array<Int> = []

// Tuplas
var color = ("ff0000", "Red");
print(color)
print(color.0)
print(color.1)

// Sets
// removing duplicated element
let set = Set([1, 3, 2, 1])
let set2: Set<String> = ["hola", "hola"]

print(set)
print(diccionario)
print(diccionario3)
print(diccionario3.count)
print(array)


// Clase 2

let animal = "parrot"

if animal.count != 6 {
    print("No parrot here")
} else if (Date.now < Date.now.addingTimeInterval(500)) {
    print("Always executes")
}

if #available(iOS 16.9, *) {
    print("Running on v16.6 or greater")
}

if #unavailable(iOS 20.0) {
    print("OS is running on a version before 20")
}



//  Ejercicio1.swift
//
//  Created by Jorge Ferrusca_C on 17/02/24.
//

import Foundation

let weather: String = "nieve";
let time: Int = 18;

if (weather == "nieve") {
    print("❄️")
} else if (weather == "lluvia") {
    print("🌧️")
}

if time >= 7 && time <= 18 {
    print("Usa bloqueador")
} else if time >= 0 && time <= 6 || time >= 19 && time <= 23 {
    print("No necesitas bloqueador")
}



// Another solution

let dark = Array(0...6) + Array(19...23)
print(dark)
let light = 7...18

if light ~= time {
    print("Usa bloqueador")
} else if dark.contains(time) {
    print("No necesitas bloqueador")
} else {
    print("does not work")
}
