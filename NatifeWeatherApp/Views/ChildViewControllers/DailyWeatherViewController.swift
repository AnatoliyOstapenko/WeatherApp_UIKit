//
//  DailyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class DailyWeatherViewController: UIViewController {
    
    private var weather: WeatherList?
    
//    private let dailyRightContainer = UIStackView()
    private let dailyTemperatureContainerView = UIView()
    private let dailyHumidityContainerView = UIView()
    private let dailyWindContainerView = UIView()

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
        dailyTemperatureContainerView.setDailyTemperatureContainerView(view: view, imageView: dailyWeatherImageView, container: dailyTemperatureContainerView)
        dailyHumidityContainerView.setDailyHumidityContainerView(view: view, imageView: dailyWeatherImageView, container: dailyHumidityContainerView)
        dailyWindContainerView.setDailyWindContainerView(view: view, imageView: dailyWeatherImageView, container: dailyWindContainerView)
        dailyTemperatureView.setDailyView(container: dailyTemperatureContainerView, subview: dailyTemperatureView)
        dailyHumidityView.setDailyView(container: dailyTemperatureContainerView, subview: dailyHumidityView)
        dailyTemperatureView.setDailyView(container: dailyHumidityContainerView, subview: dailyTemperatureView)
        dailyWindView.setDailyView(container: dailyWindContainerView, subview: dailyWindView)
    }
    
    private func updateUI() {
        dailyTemperatureView.set(indexImage: .temperature, leftIndexText: "18 C/ ", rightIndexText: "24 C")
        dailyHumidityView.set(indexImage: .humidity, leftIndexText: "30 % ")
        dailyWindView.set(indexImage: .wind, leftIndexText: "30 m/s ", rightIndexText: "↖︎")
    }
}
