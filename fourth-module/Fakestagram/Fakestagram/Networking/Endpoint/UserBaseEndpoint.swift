//
//  UserBaseEndpoint.swift
//  Fakestagram
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import Foundation

struct UserBaseEndpoint: EndpointProtocol {
    let scheme: String = "https"
    var host: String = "jsonplaceholder.typicode.com"
    var queries: [URLQueryItem]?
    var path: String
    
    init(path: String, queries: [URLQueryItem]? = nil) {
        // Allow to make request if a user exists
        if let userId = Settings.user?.id {
            self.queries = [URLQueryItem(name: "userId", value: "\(userId)")]
            if let queries {
                self.queries?.append(contentsOf: queries)
            }
            
        }
        
        self.queries = queries
        self.path = path
    }
}
