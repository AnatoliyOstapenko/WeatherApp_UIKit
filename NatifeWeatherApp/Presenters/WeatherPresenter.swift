//
//  WeatherPresenter.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func setWeather(weather: [WeatherData])
}

protocol WeatherPresenterProtocol: AnyObject {
    init (view: WeatherViewProtocol, networkManager: NetworkManagerProtocol)
    func getWeatherByLocation(lat: Double, lon: Double)
    func getWeatherByCityName(cityName: String)
}

class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol?
    private let networkManager: NetworkManagerProtocol
    
    private var weather: [WeatherData] = []
    
    required init(view: WeatherViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getWeatherByLocation(lat: Double, lon: Double) {
        networkManager.weatherByLocation(lat: lat, lon: lon) { [weak self] weather in
            guard let self = self else { return }
            self.handleWeatherResult(weather)
        }
    }

    func getWeatherByCityName(cityName: String) {
        networkManager.weatherByCityName(cityName: cityName) { [weak self] weather in
            guard let self = self else { return }
            self.handleWeatherResult(weather)
        }
    }
    
    private func handleWeatherResult(_ result: Result<WeatherModel, NetworkErrors>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let weather):
                weather.list.forEach {
                    let weatherData = WeatherData(date: $0.date.dayOfWeek,
                                                  temp: $0.main.temp.temperatured,
                                                  icon: $0.weather.first?.icon ?? "",
                                                  humidity: String($0.main.humidity),
                                                  tempMin: $0.main.tempMin.temperatured,
                                                  tempMax: $0.main.tempMax.temperatured,
                                                  speed: String($0.wind.speed),
                                                  deg: String($0.wind.deg))
                    
                    if !self.weather.contains(where: { $0.date == weatherData.date }) {
                        self.weather.append(weatherData)
                    }
                }
                self.view?.setWeather(weather: self.weather)
                
            case .failure(let error):
                print(String(describing: error.hashValue))
            }
        }
    }
}

private extension Int {
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: Double(self))
        let string = dateFormatter.string(from: date)
        return string.prefix(3).capitalized /// cut week day to 3 characters
    }
}

private extension Double {
    var temperatured: String {String(format: "%.0fº", self)}
}


