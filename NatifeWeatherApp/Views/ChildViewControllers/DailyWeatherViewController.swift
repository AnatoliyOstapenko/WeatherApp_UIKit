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

    private let weatherImageView = WeatherImageView(frame: .zero)
    
    private let temperatureView = DailyIndexesView()
    private let humidityView = DailyIndexesView()
    private let windView = DailyIndexesView()

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
        /// Set the main weather image
        weatherImageView.setWeatherImage(view: view, imageView: weatherImageView)
        /// Set containers
        temperatureContainer.setTemperatureContainer(view: view, imageView: weatherImageView, container: temperatureContainer)
        humidityContainer.setHumidityContainer(view: view, imageView: weatherImageView, container: humidityContainer)
        windContainer.setWindContainer(view: view, imageView: weatherImageView, container: windContainer)
        /// Set views
        temperatureView.setDailyView(container: temperatureContainer, subview: temperatureView)
        humidityView.setDailyView(container: humidityContainer, subview: humidityView)
        windView.setDailyView(container: windContainer, subview: windView)

    }
    
    private func updateUI() {
        temperatureView.set(indexImage: .temperature, leftIndexText: "18 C /", rightIndexText: "24C")
        humidityView.set(indexImage: .humidity, leftIndexText: "30 %")
        windView.set(indexImage: .wind, leftIndexText: "30 m/s", rightIndexText: "↖︎")
    }
}
