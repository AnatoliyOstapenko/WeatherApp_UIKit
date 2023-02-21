//
//  WeatherData.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 21.02.2023.
//

import Foundation

// Supplementary struct
struct WeatherData: Decodable, Identifiable {
    var id = UUID()
    let date: Int
    let temp: String
    let icon: String
    let humidity: String
    let tempMin: String
    let tempMax: String
    let speed: String
    let deg: String
}

extension WeatherData: Equatable {
    /// conform Equatable to find date dublicats
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return lhs.date == rhs.date
    }
}
