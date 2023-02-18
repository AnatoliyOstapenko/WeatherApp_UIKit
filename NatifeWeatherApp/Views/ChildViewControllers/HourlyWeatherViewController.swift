//
//  HourlyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 16.02.2023.
//

import UIKit

class HourlyWeatherViewController: UIViewController {
    
    private var weather: [WeatherList] = []
    private var hourlyCollectionView = HourlyWeatherCollectionView()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hourlyCollectionView.frame = view.bounds
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.lightBlue)
        view.addSubview(hourlyCollectionView)
    }
}