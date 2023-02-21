//
//  WeatherData.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 21.02.2023.
//

import Foundation

// Supplementary struct
struct WeatherData: Codable {
    var id = UUID()
    let date: String
    let temp: String
    let icon: String
    let humidity: String
    let tempMin: String
    let tempMax: String
    let speed: String
    let deg: String
    
    init(date: String, temp: String, icon: String, humidity: String, tempMin: String, tempMax: String, speed: String, deg: String) {
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
