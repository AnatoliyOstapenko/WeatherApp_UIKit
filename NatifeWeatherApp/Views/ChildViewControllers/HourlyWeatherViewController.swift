//
//  HourlyWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 16.02.2023.
//

import UIKit

class HourlyWeatherViewController: RotatableViewController {
    
    private var hourlyCollectionView = HourlyWeatherCollectionView()
    
    init(weather: [WeatherData]) {
        super.init(nibName: nil, bundle: nil)
        hourlyCollectionView.updateHourlyCV(weather: weather)
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
        hourlyCollectionView.frame = container.bounds
    }
    
    private func configureUI() {
        view.backgroundColor = WeatherColor.lightBlue
        container.setGenericContainer(view: view, container: container)
        container.addSubview(hourlyCollectionView)
    }
}
