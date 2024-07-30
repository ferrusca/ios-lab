//
//  Extensions.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
