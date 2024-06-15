//
//  EndpointProtocol.swift
//  Fakestagram
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var scheme: String { get }
    var host: String { get }
    var queries: [URLQueryItem]? { get }
    func getRequest() -> URLRequest?
}

// Giving default functionality to getRequest() method
extension EndpointProtocol {
    func getRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queries
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}
