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


// Supplementary struct
struct WeatherData: Codable {
    var id = UUID()
    let date: String
    let temp: Int
    let icon: String
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
    let speed: Double
    let deg: Int
    
    init(date: String, temp: Int, icon: String, humidity: Int, tempMin: Double, tempMax: Double, speed: Double, deg: Int) {
        self.date = date
        self.temp = temp
        self.icon = icon
        self.humidity = humidity
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.speed = speed
        self.deg = deg
    }
}

extension WeatherData: Equatable {
    /// conform Equatable to find date dublicats
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return lhs.date == rhs.date
    }
}
