//
//  Constants.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

enum Constants {
    static let baseURLString = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid="
    static let key = "d5422e041170c6bebf329350df7140bf"
    static let baseIconURL = "https://openweathermap.org/img/wn/"
    static let darkBlue = "#4a90e2"
    static let lightBlue = "#5a9ff0"
}

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let map = UIImage(systemName: "map.circle")
    static let sun = UIImage(systemName: "cloud.sun")
    static let temperature = UIImage(systemName: "thermometer.medium")
    static let humidity = UIImage(systemName: "humidity")
    static let wind = UIImage(systemName: "wind")
}

/// forecast weather by location
///https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=d5422e041170c6bebf329350df7140bf&lat=42.3601&lon=71.0589


/// forecast weather by city name
///https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=d5422e041170c6bebf329350df7140bf&q=kyiv

struct MockWeather {
    static let mockWeather = WeatherList(main: Main(temp: 0, humidity: 0, tempMin: 0, tempMax: 0),
                                  weather: [Weather(icon: "Foo")],
                                  date: 0,
                                  wind: Wind(speed: 1, deg: 2))
    
    static let mockWeatherArray = Array(repeating: mockWeather, count: 3)
    
}
