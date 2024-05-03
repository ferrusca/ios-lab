import Foundation

func optional(string: String?) -> Void {
    guard let definedValue = string else {
        print("Empty value")
        return
    }
    
    print(definedValue)
}

let testString: String? = "Hello world"
var testString2: String? = nil;

optional(string: testString)
optional(string: testString2)
