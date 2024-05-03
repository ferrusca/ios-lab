import Foundation


func receiveBox(with: String?) -> String {
    guard let boxContent = with else {
        return "It's empty! You ripped me off!"
    }
    
    if boxContent == "🐈" {
        return "Thanks for my cat Schrödinger!"
    }
        
    return "This ain't a cat!"
}

var emptyString: String?

print(receiveBox(with: "Not a cat"))
print(receiveBox(with: "🐈"))
print(receiveBox(with: emptyString))
