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
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var topNameViewContainer = UIView()
    var dailyWeatherViewContainer = UIView()
    var hourlyWeatherViewContainer = UIView()
    var forecastWeatherViewContainer = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setChildView()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.darkBlue)
        scrollView.setScrollView(view: view, scrollView: scrollView)
        contentView.setContentView(view: scrollView, content: contentView)
        topNameViewContainer.setTopNameViewContainer(view: contentView,
                                                     container: topNameViewContainer)
        dailyWeatherViewContainer.setDailyWeatherViewContainer(view: contentView,
                                                               topcontainer: topNameViewContainer,
                                                               container: dailyWeatherViewContainer)
        
        /// delete after debuging:
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
        addChildVC(childVC: TopNameViewController(weather: MockWeather.mockWeather), containerView: topNameViewContainer)
        addChildVC(childVC: DailyWeatherViewController(weather: MockWeather.mockWeather), containerView: dailyWeatherViewContainer)
    }


}

// MARK: - Update weather
extension WeatherMainScreen: WeatherViewProtocol {
    func setWeather(weather: WeatherModel) {
        self.weather = weather.list
        print(weather.list)
    }
}

