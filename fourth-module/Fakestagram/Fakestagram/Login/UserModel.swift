//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import Foundation

enum UserModelError: Error, LocalizedError {
    case userNotFound
    case fileError
    case parseError
    
    var errorDescription: String? {
        switch self {
        case .userNotFound: "User not found"
        case .fileError: "File not found"
        case .parseError: "Not able to deserialize users"
        }
    }
}

class UserModel {
    var user: User?
    
    // throws indicates this function may throw an error
    func findUser(by email: String) throws {
        // retrieving data from the users.json file
        guard let url = Bundle.main.url(forResource: "Users", withExtension: "json") else {
            throw UserModelError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw UserModelError.fileError }
        guard let usersObject = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            throw UserModelError.parseError
        }
        let userDTO = usersObject.first { user in
            print(user)
            print(email)
            print((user["email"] as? String) == email.lowercased())
            return (user["email"] as? String) == email.lowercased()
        }
        guard let userDTO else { throw UserModelError.userNotFound }
        print(userDTO)
//        User(id: userDTO["id"] name: userDTO["name"], username: userDTO["username"] ?? "DefaultValue", email: userDTO["email"] ?? "DefaultValue")
//        user = User(id: userDTO.id, name: userDTO.name, username: userDTO.username, email: userDTO.email)

    }
}
