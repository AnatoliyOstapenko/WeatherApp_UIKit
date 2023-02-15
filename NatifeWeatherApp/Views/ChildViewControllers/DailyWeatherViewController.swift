//
//  DailyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class DailyWeatherViewController: UIViewController {
    
    private var weather: WeatherList?
    
    private let dailyRightContainer = UIStackView()
    private let dailyWeatherImageView = WeatherImageView(frame: .zero)
    private let dailyTemperatureView = DailyIndexesView()
    private let dailyHumidityView = DailyIndexesView()
    private let dailyWindView = DailyIndexesView()
    private let dailyDirectionView = WeatherImageView(frame: .zero)

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
        dailyRightContainer.setDailyRightContainer(view: view, container: dailyRightContainer)
        dailyRightContainer.addAllSubbviews(dailyTemperatureView, dailyHumidityView, dailyWindView)
    }
    
    private func updateUI() {
        dailyTemperatureView.set(indexImage: .temperature, indexText: "24 C")
        dailyHumidityView.set(indexImage: .humidity, indexText: "30 %")
        dailyWindView.set(indexImage: .wind, indexText: "10 m/s")
    }
}
