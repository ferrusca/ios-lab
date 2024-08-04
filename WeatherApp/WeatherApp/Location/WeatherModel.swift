//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Jorge Ferrusca on 03/08/24.
//

import Foundation

struct ConditionResponse: Decodable {
    // the icon path
    var icon: String
}

struct LocationResponse: Decodable {
    let name: String
    let region: String
    let localtime: String
    let lat: Double
    let lon: Double
}

struct CurrentConditionsResponse: Decodable {
    let farenheitDegrees: Double
    let celsiusDegrees: Double
    let uv: Double
    let isDay: Int
    let lastUpdated: String
    let condition: ConditionResponse
    
    private enum CodingKeys: String, CodingKey {
        case uv
        case condition
        case farenheitDegrees = "temp_f"
        case celsiusDegrees = "temp_c"
        case isDay = "is_day"
        case lastUpdated = "last_updated"
    }
    
}

struct CurrentWeatherResponse: Decodable {
    let locationInfo: LocationResponse
    let currentConditions: CurrentConditionsResponse
    
    private enum CodingKeys: String, CodingKey {
        case locationInfo = "location"
        case currentConditions = "current"
    }
}

class WeatherModel {
    private let apiKey = "fc45889b743d452dbdb25953243107"
    
    private func buildEndpoint(location: Location) -> EndpointProtocol {
        let queries = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: location.name)
        ]
        
        
        return WeatherBaseEndpoint(path: "/current.json", queries: queries)
    }
    
    public func currentWeatherFrom(location: Location, completitionHandler: @escaping (Error?, CurrentWeatherResponse?) -> Void) {
        RequestHandler().get(buildEndpoint(location: location)) {
            (result: Result<CurrentWeatherResponse, Error>) in
            switch result {
            case .failure(let failure):
                print(failure)
                completitionHandler(failure, nil)
            case .success(let response):
                completitionHandler(nil, response)
            }
        }
    }
}
