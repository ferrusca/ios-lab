//
//  Extensions.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import UIKit

// Generic way to be able to decode to the class used - eg. MyAwesomeDTO(data: data)
extension Decodable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIView {
    func setFontColor(_ color: UIColor) {
        if let label = self as? UILabel {
            label.textColor = color
        } else if let textField = self as? UITextField {
            textField.textColor = color
        } else if let textView = self as? UITextView {
            textView.textColor = color
        }
        
        for subview in subviews {
            subview.setFontColor(color)
        }
    }
}
