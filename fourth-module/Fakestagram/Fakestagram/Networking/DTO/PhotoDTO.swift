//
//  PhotoDTO.swift
//  Fakestagram
//
//  Created by Jorge Ferrusca on 07/06/24.
//

import Foundation

struct PhotoDTO: Decodable {
    var id: Int
    var url: String
    var title: String
}
