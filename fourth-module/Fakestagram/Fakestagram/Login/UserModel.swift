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
    static var hola: String { return "Hola" }
    
    var user: User? {
        didSet {
            Settings.user = user
        }
    }
}
 
extension UserModel {
    // throws indicates this function may throw an error
    func findUserByDictionary(by email: String) throws {
        // retrieving data from the users.json file
        guard let url = Bundle.main.url(forResource: "Users", withExtension: "json") else {
            throw UserModelError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw UserModelError.fileError }
        guard let usersObject = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            throw UserModelError.parseError
        }
        let userDTO = usersObject.first { user in
            return (user["email"] as? String) == email.lowercased()
        }
        guard let userDTO else { throw UserModelError.userNotFound }
        let user = User(id: userDTO["id"] as? Int ?? 0, name: userDTO["name"] as? String ?? "DefaultValue", username: userDTO["username"] as? String ?? "DefaultValue", email: userDTO["email"] as? String ?? "DefaultValue")
//        user = User(id: userDTO.id, name: userDTO.name, username: userDTO.username, email: userDTO.email)

    }
    
    
    func getUserFromDTO(_ dto: UserDTO) -> User {
        guard !dto.name.isEmpty, !dto.email.isEmpty, !dto.username.isEmpty else { fatalError("Empty fields for user") }
        return User(id: dto.id, name: dto.name, username: dto.username, email: dto.email)
        
    }
    
    func findUser(by email: String) throws {
        print("printtt ")
        // retrieving data from the users.json file
        guard let url = Bundle.main.url(forResource: "Users", withExtension: "json") else {
            throw UserModelError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw UserModelError.fileError }
        
        // MARK: decoding as User by providing UserDTO
//        Option 1 (without creating an extension of Decodable)
//        let userDTOs = try JSONDecoder().decode([UserDTO].self, from: data)
        
//        Option 2 (with extension Decodable)
        let userDTOs = try [UserDTO](data: data)
        let userDTO = userDTOs.first { user in
            user.email == email.lowercased()
        }
        guard let userDTO else { throw UserModelError.userNotFound }
        user = getUserFromDTO(userDTO)
    }
}
