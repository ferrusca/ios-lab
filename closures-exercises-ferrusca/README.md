[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/XsOqwCNZ)
# Closure Exercises

## First Challenge
We sorted a collection by returning a new instance of Array with its integers sorted from smallest to largest. You can also sort collections in place – meaning modifying the existing collection, rather than returning a new one. 

Change the way you sort volunteerCounts to sort the array in place from smallest to largest.

> [!NOTE]  
> check the documentation to find the method that can help you achieve this


## Second Challenge
Write a function named `applyClosureNTimes` that takes an integer N and a closure. The function must call the closure N times. 
The closure will not take any parameters, but will have to print "I love closures" each time it's runned.

### Example
Function call
```swift
applyClosureNTimes(3) { 
    print("I love closures")
}
```

Output
```
I love closures
I love closures
I love closures
```

## Third Challenge
Use `filter` to create an array called `multiples` that contains all the multiples of 5 from an array of integers called `numbers`. Print the resulting array.

### Example
Input
```
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
```

Output
```
[5, 10, 15]
```



## Fourth Challenge
Find the largest number from an array of integers called `numbers` by using the `reduce` method. Print the resulting number.

### Example
Input
```
let numbers = [1, 2, 3, 4, 5, 6, 7]
```

Output
```
7
```


## Fifth Challenge
Join the all the values from an array of strings called `strings` into a single one using the method `reduce`. Add spaces between each value. Print the resulting string.

### Example
Input
```
let strings = ["I", "love", "functional", "programming"]
```

Output
```
"I love functional programming"
```


## Sixth Challenge
Find the sum of the squares of all the odd numbers from an array of integers called `numbers`. Use the methods `map`, `filter` and `reduce` to solve this problem. Print the resulting number.

### Example
Input
```
let numbers = [1, 2, 3, 4, 5, 6]
```

Output
```
35 // 1 + 9 + 25 -> 35
```


## Seventh Challenge
Create a function called `combine` that takes 2 arrays (of the same length) and a closure. The function must combine the two arrays into a single one by multiplying the numbers in the same positions in the array. Print the resulting array.

### Example
Function call
```swift
let first = [1, 2, 3, 4]
let second = [5, 5, 5, 3]

combine(first, second) {
    $0 * $1
}

```

Output
```
[5, 10, 15, 12]
``` 
