//
//  PictureType.swift
//  photoApp
//
//  Created by Jorge Ferrusca_C on 05/04/24.
//

import UIKit

enum PictureType {
    case dog, cat
    
    // computed variable
    var captionedPictures: [CaptionedPicture] {
        switch self {
        case .dog: return [
            // different ways to refer to assets
            CaptionedPicture(image: .dog1, caption: "Dog 1"),
            CaptionedPicture(image: UIImage(resource: .dog2Jpg), caption: "Dog 2"),
            CaptionedPicture(image: UIImage(resource: .dog3), caption: "Third dog!")
        ]
        case .cat: return [
            // different ways to refer to assets
            CaptionedPicture(image: .images2, caption: "1st cat"),
            CaptionedPicture(image: UIImage(resource: .images3), caption: "2nd cat"),
            CaptionedPicture(image: UIImage(resource: .images4), caption: "3rd cat")
        ]
        }
    }
}
