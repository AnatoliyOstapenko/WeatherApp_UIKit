//
//  ForecastWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 16.02.2023.
//

import UIKit

class ForecastWeatherViewController: RotatableViewController {
    
    private let tableView = ForecastTableView()
    
    init(weather: [WeatherData]) {
        super.init(nibName: nil, bundle: nil)
        tableView.updateForecastTV(weather: weather)
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
        tableView.frame = container.bounds
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        container.setGenericContainer(view: view, container: container)
        container.addSubview(tableView)
    }
}
