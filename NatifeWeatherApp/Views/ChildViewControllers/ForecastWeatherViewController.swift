//
//  ForecastWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 16.02.2023.
//

import UIKit

class ForecastWeatherViewController: UIViewController {
    
    private var weather: [WeatherList] = []
    
    init(weather: [WeatherList]) {
        super.init(nibName: nil, bundle: nil)
        self.weather = weather
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
}
