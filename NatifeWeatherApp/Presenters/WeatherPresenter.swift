//
//  WeatherPresenter.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func setWeather(weather: WeatherModel)
}

protocol WeatherPresenterProtocol: AnyObject {
    init (view: WeatherViewProtocol, networkManager: NetworkManagerProtocol)
    func getWeatherByLocation(lat: Double, lon: Double)
    func getWeatherByCityName(cityName: String)
}

class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol?
    private let networkManager: NetworkManagerProtocol
    
    required init(view: WeatherViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getWeatherByLocation(lat: Double, lon: Double) {
        networkManager.weatherByLocation(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.view?.setWeather(weather: weather)
                case .failure(let error):
                    print(String(describing: error.hashValue))
                }
            }
            
        }
    }
    
    func getWeatherByCityName(cityName: String) {
        networkManager.weatherByCityName(cityName: cityName) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.view?.setWeather(weather: weather)
                case .failure(let error):
                    print(String(describing: error.hashValue))
                }
            }
        }
    }
}


