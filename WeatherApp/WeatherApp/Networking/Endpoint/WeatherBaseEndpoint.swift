//
//  BaseEndpoint.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import Foundation

struct WeatherBaseEndpoint: EndpointProtocol {
    let scheme: String = "https"
    var host: String = "api.weatherapi.com"
    var queries: [URLQueryItem]?
    var path: String
    
    init(path: String, queries: [URLQueryItem]? = nil) {
        if queries != nil {
            
        }
        self.queries = queries
        self.path = "/v1" + path
    }
}

