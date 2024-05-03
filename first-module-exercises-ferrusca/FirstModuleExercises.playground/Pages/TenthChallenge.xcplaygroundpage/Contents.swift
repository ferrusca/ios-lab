//: [Previous](@previous)

import Foundation

let someStrings: [String?] = ["This", "is", nil, "not", nil, "a", "drill", nil, "!"]

print(someStrings.compactMap{ $0 }
    .reduce("") {
    fullSentence, word in
        if (fullSentence == "" ) {
            return "\(word)"
        }
        if word.contains(/[\?!]/) {
           return "\(fullSentence)\(word)"
        }
        
        return "\(fullSentence) \(word)"
})



// This is not a drill!


