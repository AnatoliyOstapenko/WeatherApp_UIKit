//
//  WeatherMainScreen.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

class WeatherMainScreen: UIViewController {
    
    // MARK: - Object relations
    var presenter: WeatherPresenterProtocol?
    var coordinator: CoordinatorProtocol?
   
    // MARK: - Private properties
    private var weather: [WeatherList] = []
    
    let mainStackView = UIStackView()
    private let topNameViewContainer = UIView()
    private let dailyWeatherViewContainer = UIView()
    private let hourlyWeatherViewContainer = UIView()
    private let forecastWeatherViewContainer = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setChildView()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.darkBlue)
        mainStackView.setMainStackVeiw(view: view, stackView: mainStackView)
        mainStackView.addAllSubbviews(topNameViewContainer, dailyWeatherViewContainer, hourlyWeatherViewContainer, forecastWeatherViewContainer)
        
        /// delete after debuging:
        dailyWeatherViewContainer.backgroundColor = .yellow
        hourlyWeatherViewContainer.backgroundColor = .cyan
        forecastWeatherViewContainer.backgroundColor = .brown
    }
    
    private func addChildVC(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func setChildView() {
        self.addChildVC(childVC: TopNameViewController(weather: self.weather.first ?? MockWeather.mockWeather), containerView: topNameViewContainer)
    }


}

// MARK: - Update weather
extension WeatherMainScreen: WeatherViewProtocol {
    func setWeather(weather: WeatherModel) {
        self.weather = weather.list
        print(weather.list)
    }
}

