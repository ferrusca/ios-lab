//
//  RequestHandlerError.swift
//  Fakestagram
//
//  Created by Jorge Ferrusca on 15/06/24.
//

import Foundation

enum RequestHandlerError: Error, LocalizedError {
    case badResponse(Int, String)
    case badRequest
    case emptyData
    case unexpectedResponse
    
    var errorDescription: String? {
        switch self {
        case .badRequest: return "The request could not be built."
        case .badResponse(let code): return "HTTP response \(code)"
        default: return ""
        }
    }
}
