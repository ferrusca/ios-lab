//
//  UserBaseEndpoint.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import Foundation

struct UserBaseEndpoint: EndpointProtocol {
    let scheme: String = "https"
    var host: String = "pokeapi.co"
    var queries: [URLQueryItem]?
    var path: String
    
    init(path: String, queries: [URLQueryItem]? = nil) {
        if queries != nil {
            
        }
        self.queries = queries
        self.path = "/api/v2" + path
    }
}

