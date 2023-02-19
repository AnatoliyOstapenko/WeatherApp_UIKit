//
//  DailyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class DailyWeatherViewController: RotatableViewController {
    
    private var weather: WeatherList?

    private let weatherImageView = WeatherImageView(frame: .zero)
    private let temperatureContainer = UIView()
    private let humidityContainer = UIView()
    private let windContainer = UIView()
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
        /// Set the main container
        container.setGenericContainer(view: view, container: container)
        
        /// Set the weather image
        weatherImageView.setWeatherImage(view: container, imageView: weatherImageView)
        
        /// Set UI containers
        temperatureContainer.setTemperatureContainer(view: container, container: temperatureContainer)
        humidityContainer.setHumidityContainer(view: container, imageView: weatherImageView, container: humidityContainer)
        windContainer.setWindContainer(view: container, container: windContainer)
        
        /// Set UI views
        temperatureView.setDailyView(container: temperatureContainer, subview: temperatureView)
        humidityView.setDailyView(container: humidityContainer, subview: humidityView)
        windView.setDailyView(container: windContainer, subview: windView)

    }
    
    private func updateUI() {
        temperatureView.set(indexImage: .temperature, leftIndexText: "18 C /", rightIndexText: "24 C")
        humidityView.set(indexImage: .humidity, leftIndexText: "30 %")
        windView.set(indexImage: .wind, leftIndexText: "30 m/s", rightIndexText: "↖︎")
    }
}
