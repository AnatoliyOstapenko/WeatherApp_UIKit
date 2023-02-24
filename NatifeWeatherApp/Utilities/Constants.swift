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
    static let superscriptZero = "\u{2070}\u{2070}"
    static let cellItemWidth: CGFloat = 70
}

enum ActionTitle {
    static let currentLocation  = NSLocalizedString("Current location", comment: "")
    static let findLocation = NSLocalizedString("Вибір точки на карті", comment: "")
    static let findCity = NSLocalizedString("Search for places", comment: "")
}

enum SFSymbols {
    static let pin = UIImage(systemName: "mappin.and.ellipse")
    static let map = UIImage(systemName: "map.circle")
    static let sun = UIImage(systemName: "cloud.sun")
    static let temperature = UIImage(systemName: "thermometer.medium")
    static let humidity = UIImage(systemName: "humidity")
    static let wind = UIImage(systemName: "wind")
    static let glass = UIImage(systemName: "magnifyingglass")
    static let locationGlass = UIImage(systemName: "location.magnifyingglass")
    static let location = UIImage(systemName: "location.fill")
}

enum WeatherColor {
    static let darkBlue = UIColor(hex: Constants.darkBlue)
    static let lightBlue = UIColor(hex: Constants.lightBlue)
}
