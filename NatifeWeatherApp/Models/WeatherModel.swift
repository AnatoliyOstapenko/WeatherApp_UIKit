//
//  WeatherModel.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import Foundation

struct WeatherModel: Decodable {
    let list: [WeatherList]
}

struct WeatherList: Decodable {
    let main: Main
    let weather: [Weather]
    let date: Int
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case main, weather, wind
        case date = "dt"
    }
}

struct Main: Decodable {
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

struct Weather: Decodable {
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int /// direction
}


