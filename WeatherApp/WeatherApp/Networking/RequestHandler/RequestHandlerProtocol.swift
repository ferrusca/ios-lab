//
//  RequestHandlerProtocol.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import Foundation

protocol RequestHandlerProtocol {
    var urlSession: URLSession { get }
    func get<T: Decodable>(_ endpoint: EndpointProtocol, handler: @escaping (Result<T, Error>) -> Void)
}
