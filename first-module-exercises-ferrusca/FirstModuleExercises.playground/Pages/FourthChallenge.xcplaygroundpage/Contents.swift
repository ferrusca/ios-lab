import Foundation

func login(password: String) -> Bool {
    return password.count >= 6 && password.contains(".") && password.contains(/[0-9]/) && password.contains(/[A-Z]/)
    
}

login(password: "foo")
login(password: "foobar")
login(password: "foobar1.")
login(password: "fooBar1.")



