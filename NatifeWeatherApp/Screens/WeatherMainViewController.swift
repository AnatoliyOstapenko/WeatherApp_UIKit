//
//  WeatherMainViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit
import CoreLocation

class WeatherMainViewController: UIViewController {
    
    // MARK: - Object relations
    var presenter: WeatherPresenterProtocol?
    var coordinator: CoordinatorProtocol?
   
    // MARK: - Private properties

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let topNameContainer = UIView()
    private let dailyWeatherContainer = UIView()
    private let hourlyWeatherContainer = UIView()
    private let forecastWeatherContainer = UIView()
    private let locationManager = CLLocationManager()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setInitialLocation()
    }
    
    // MARK: - Private methods
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
    
    private func setChildView(weather: [WeatherData], filteredWeather: [WeatherData], city: String) {
        addChildVC(childVC: TopNameViewController(weather: weather, cityName: city, delegate: self), containerView: topNameContainer)
        addChildVC(childVC: DailyWeatherViewController(weather: weather), containerView: dailyWeatherContainer)
        addChildVC(childVC: HourlyWeatherViewController(weather: weather), containerView: hourlyWeatherContainer)
        addChildVC(childVC: ForecastWeatherViewController(weather: filteredWeather), containerView: forecastWeatherContainer)
    }
    
    private func removeChild() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    
    private func setInitialLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func configureUI() {
        view.backgroundColor = WeatherColor.darkBlue
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
}

// MARK: - Update weather
extension WeatherMainViewController: WeatherViewProtocol {
    func setWeather(weather: [WeatherData], filteredWeather: [WeatherData], city: String) {
        setChildView(weather: weather, filteredWeather: filteredWeather, city: city)        
    }
}

extension WeatherMainViewController: TopCoordinatesProtocol {
    func requestLocation() {
        removeChild()
        locationManager.startUpdatingLocation()
    }
    
    func coordinates(lat: Double, lon: Double) {
        removeChild()
        presenter?.getWeatherByLocation(lat: lat, lon: lon)
    }
    
    
}
// MARK: - CLLocationManagerDelegate
extension WeatherMainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, location.horizontalAccuracy > 0 else { return }
        locationManager.stopUpdatingLocation()
        let lon = Double(location.coordinate.longitude)
        let lat = Double(location.coordinate.latitude)
        /// Initial location
        presenter?.getWeatherByLocation(lat: lat, lon: lon)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location update failed, \(error) ")
    }
}

