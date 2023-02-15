//
//  DailyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class DailyWeatherViewController: UIViewController {
    
    private var weather: WeatherList?

    private let temperatureContainer = UIView()
    private let humidityContainer = UIView()
    private let windContainer = UIView()

    private let dailyWeatherImageView = WeatherImageView(frame: .zero)
    private let dailyTemperatureView = DailyIndexesView()
    private let dailyHumidityView = DailyIndexesView()
    private let dailyWindView = DailyIndexesView()

    init(weather: WeatherList) {
        super.init(nibName: nil, bundle: nil)
        self.weather = weather
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateUI()
    }
    
    private func configureUI() {
        dailyWeatherImageView.setDailyWeatherImageView(view: view, imageView: dailyWeatherImageView)
        
        temperatureContainer.setDailyTemperatureContainerView(view: view, imageView: dailyWeatherImageView, container: temperatureContainer)
        humidityContainer.setDailyHumidityContainerView(view: view, imageView: dailyWeatherImageView, container: humidityContainer)
        windContainer.setDailyWindContainerView(view: view, imageView: dailyWeatherImageView, container: windContainer)
        
        dailyTemperatureView.setDailyView(container: temperatureContainer, subview: dailyTemperatureView)
        dailyHumidityView.setDailyView(container: temperatureContainer, subview: dailyHumidityView)
        dailyTemperatureView.setDailyView(container: humidityContainer, subview: dailyTemperatureView)
        
        dailyWindView.setDailyView(container: windContainer, subview: dailyWindView)
    }
    
    private func updateUI() {
        dailyTemperatureView.set(indexImage: .temperature, leftIndexText: "18 C/", rightIndexText: "24C")
        dailyHumidityView.set(indexImage: .humidity, leftIndexText: "30 %")
        dailyWindView.set(indexImage: .wind, leftIndexText: "30 m/s", rightIndexText: "↖︎")
    }
}
