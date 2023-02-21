//
//  WeatherPresenter.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func setWeather(weather: [WeatherData], filteredWeather: [WeatherData])
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
    private var filteredWeather: [WeatherData] = []
    
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
                    let weatherData = WeatherData(date: $0.date,
                                                  temp: $0.main.temp.temperatured,
                                                  icon: $0.weather.first?.icon ?? "",
                                                  humidity: String($0.main.humidity),
                                                  tempMin: $0.main.tempMin.temperatured,
                                                  tempMax: $0.main.tempMax.temperatured,
                                                  speed: String($0.wind.speed),
                                                  deg: String($0.wind.deg))
                    /// add all data from weather API
                    self.weather.append(weatherData)
                    /// add filtered data day by day for Forecast VC
                    if !self.filteredWeather.contains(where: { $0.date.dayOfWeek == weatherData.date.dayOfWeek }) {
                        self.filteredWeather.append(weatherData)
                    }
                }
                self.view?.setWeather(weather: self.weather,
                                      filteredWeather: self.filteredWeather)
                
            case .failure(let error):
                print(String(describing: error.hashValue))
            }
        }
    }
}


