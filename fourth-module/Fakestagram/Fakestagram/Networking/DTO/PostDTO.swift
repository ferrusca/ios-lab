//
//  PostDTO.swift
//  Fakestagram
//
//  Created by Jorge Ferrusca on 07/06/24.
//

import Foundation

struct PostDTO: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
