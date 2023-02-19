//
//  ForecastWeatherViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 16.02.2023.
//

import UIKit

class ForecastWeatherViewController: UIViewController {
    
    private let container = UIView()
    private let tableView = ForecastTableView()
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
        container.setGenericContainer(view: view, container: container)
        container.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = container.bounds
    }
}

extension ForecastWeatherViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        let isPortrait = UIDevice.current.orientation.isPortrait
        
        /// Change constraints when device rotating has been changed
        container.snp.updateConstraints { make in
            make.leading.equalTo(isPortrait ? 0 : 60)
            make.trailing.equalTo(isPortrait ? 0 : -60)
        }
    }
}
