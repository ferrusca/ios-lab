//
//  Extensions.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import UIKit

extension UIView {
    static var name: String { String(describing: Self.self) }
}

extension UIViewController {
    func presentErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

// Generic way to be able to decode to the class used - eg. MyAwesomeDTO(data: data)
extension Decodable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

// Serializes the passed data
extension Data {
    init(from object: Encodable) throws {
        self = try JSONEncoder().encode(object)
    }
}
