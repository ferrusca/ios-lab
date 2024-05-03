[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Q3vMgmeN)
# Functions Exercises

## First Challenge
Like if/else conditions, guard statements support the use of multiple clauses to perform additional checks. Using additional clauses with a guard statement gives you further control over the statement’s condition. 

Refactor the `greetByMiddleName(fromFullName:)` function to have an additional clause in its guard statement. This clause should check whether the middle name is longer than 10 characters. If it is, then greet the person with their first name, their middle initial (the first letter of the middle name followed by a period), and their last name instead.

For example, if the name is Alois Rumpelstiltskin Chaz, the function should print Hey, Alois R. Chaz.

> [!NOTE]  
> You can use `"Some string".first` to get the first character of a string.
> You can use `"Some string".count` to get the number of characters of a string.

## Second Challenge
Write a function called `siftBeans(fromGroceryList:)` that takes a grocery list (as an array of strings) and “sifts out” the beans from the other groceries. 

The function should take one argument that has a parameter name called list, and it should return a named tuple of the type `(beans: [String], otherGroceries: [String])`

Here is an example of how you should be able to call your function and what the result should be:

```swift
let result = siftBeans(fromGroceryList: ["green beans",
                                         "milk",
                                         "black beans",
                                         "pinto beans",
                                         "apples"])

print(result.beans) //["green beans", "black beans", "pinto beans"]
print(result.otherGroceries) //["milk", "apples"]
```

> [!Note]
> You may need to use a function on the String type called `hasSuffix(_:)`. 
