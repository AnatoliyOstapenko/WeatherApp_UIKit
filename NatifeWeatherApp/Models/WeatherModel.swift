//
//  WeatherModel.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import Foundation

struct WeatherModel: Codable {
    let list: [WeatherList]
}

struct WeatherList: Codable {
    let main: Main
    let weather: [Weather]
    let date: Int
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case main, weather, wind
        case date = "dt"
    }
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int /// direction
}


