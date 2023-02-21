//
//  ForecastWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 16.02.2023.
//

import UIKit

class ForecastWeatherViewController: RotatableViewController {
    
    private let tableView = ForecastTableView()
    private var weather: [WeatherData] = []
    
    init(weather: [WeatherData]) {
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
        container.setGenericContainer(view: view, container: container)
        container.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = container.bounds
    }
}
