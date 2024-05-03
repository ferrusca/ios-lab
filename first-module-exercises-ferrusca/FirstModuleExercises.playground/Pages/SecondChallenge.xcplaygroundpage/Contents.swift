import Foundation

func comparison(number: Double) -> String {
    return  number > 0 ? "Positive" :
            number < 0 ? "Negative" :
            "Zero"
}

print(comparison(number: 103223))
print(comparison(number: -2121))
print(comparison(number: -0))
