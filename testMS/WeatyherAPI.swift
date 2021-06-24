//
//  WeatyherAPI.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import Foundation

class WeatherAPI {
    
    static let shared = WeatherAPI()
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private let api = "cbce11c07bc8ff5271528a8fcf3fb9d0"
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: api),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    func fetchWeather(for city: String) async throws -> Weather {
        guard let url = absoluteURL(city: city) else { return Weather.placeholder }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else { return Weather.placeholder}
        
        return weather
    }
}
