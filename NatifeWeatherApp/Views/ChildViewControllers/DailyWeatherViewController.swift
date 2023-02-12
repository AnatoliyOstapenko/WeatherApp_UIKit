//
//  DailyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class DailyWeatherViewController: UIViewController {
    
    private var weather: WeatherList?
    
    private let dailyMainContainer = UIStackView()
    private let dailyRightContainer = UIStackView()
    private let dailyWeatherImageView = WeatherImageView(frame: .zero)

    init(weather: WeatherList? = nil) {
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
        
    }

}
