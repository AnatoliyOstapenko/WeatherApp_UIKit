//
//  WeatherMainViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

class WeatherMainViewController: UIViewController {
    
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
    
    ///Mock data for debugging
    let cityName = "london"
    let lat = "54.687157"
    let lon = "25.279652"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setChildView()
        presenter?.getWeatherByCityName(cityName: cityName)
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
        /// Pass container from superclass to childVC
        if let childVC = childVC as? TopNameViewController {
            childVC.coordinator = self.coordinator
        }
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func setChildView() {
        addChildVC(childVC: TopNameViewController(weather: WeatherMockModel.mockWeather), containerView: topNameContainer)
        addChildVC(childVC: DailyWeatherViewController(weather: WeatherMockModel.mockWeather), containerView: dailyWeatherContainer)
        addChildVC(childVC: HourlyWeatherViewController(weather: WeatherMockModel.mockWeatherArray), containerView: hourlyWeatherContainer)
        addChildVC(childVC: ForecastWeatherViewController(weather: WeatherMockModel.mockWeatherArray), containerView: forecastWeatherContainer)
    }
}

// MARK: - Update weather
extension WeatherMainViewController: WeatherViewProtocol {
    func setWeather(weather: WeatherModel) {
        self.weather = weather.list
        print(weather.list)
    }
}

