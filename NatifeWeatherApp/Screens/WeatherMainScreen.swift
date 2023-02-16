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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let topNameContainer = UIView()
    private let dailyWeatherContainer = UIView()
    private let hourlyWeatherContainer = UIView()
    private let forecastWeatherContainer = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setChildView()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.darkBlue)
        /// Set ScrollView for adaptive layout
        scrollView.setScrollView(view: view, scrollView: scrollView)
        contentView.setContentView(view: scrollView, content: contentView)
        /// Set containers layouts
        topNameContainer.setTopNameContainer(view: contentView,
                                                     container: topNameContainer)
        dailyWeatherContainer.setDailyWeatherContainer(view: contentView,
                                                               topcontainer: topNameContainer,
                                                               container: dailyWeatherContainer)
        hourlyWeatherContainer.setHourlyWeatherContainer(view: contentView, topcontainer: dailyWeatherContainer, container: hourlyWeatherContainer)
        forecastWeatherContainer.setForecastWeatherContainer(superview: view, view: contentView, topcontainer: hourlyWeatherContainer, container: forecastWeatherContainer)
    }
    
    private func addChildVC(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func setChildView() {
        addChildVC(childVC: TopNameViewController(weather: MockWeather.mockWeather), containerView: topNameContainer)
        addChildVC(childVC: DailyWeatherViewController(weather: MockWeather.mockWeather), containerView: dailyWeatherContainer)
        addChildVC(childVC: HourlyWeatherViewController(weather: MockWeather.mockWeatherArray), containerView: hourlyWeatherContainer)
        addChildVC(childVC: ForecastWeatherViewController(weather: MockWeather.mockWeatherArray), containerView: forecastWeatherContainer)
    }


}

// MARK: - Update weather
extension WeatherMainScreen: WeatherViewProtocol {
    func setWeather(weather: WeatherModel) {
        self.weather = weather.list
        print(weather.list)
    }
}

