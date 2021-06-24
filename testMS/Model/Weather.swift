//
//  Weather.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import Foundation

public struct Weather: Decodable {
    let city: City?
    let list: [WeatherList]?
    
    static var placeholder: Self {
        return Weather(city: nil, list: nil)
    }
}

struct City: Decodable {
    let name: String
}

struct WeatherList: Decodable {
    let id = UUID()
    let main: DailyWeather?
    let weather: [WeatherDesc]?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case main, weather
        case date = "dt_txt"
    }
}

struct DailyWeather: Decodable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
    
}

struct WeatherDesc: Decodable {
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "main"
    }
}
