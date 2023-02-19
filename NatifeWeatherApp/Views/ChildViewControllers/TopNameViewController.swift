//
//  TopNameViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class TopNameViewController: UIViewController {
    
    private var weather: WeatherList?
    
    private let container = UIView()
    private let mapImageView = UIImageView()
    private let locationImageView = UIImageView()
    private let cityNameLabel = WeatherLabel(textAlignment: .left, fontSize: 28, weight: .bold)
    private let currentDateLabel = WeatherLabel(textAlignment: .left, fontSize: 18, weight: .medium)
    
    init(weather: WeatherList) {
        super.init(nibName: nil, bundle: nil)
        self.weather = weather
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateUI()
    }
    
    private func configureUI() {
        /// Set generic container to change constraints when rotating the iPhone
        container.setGenericContainer(view: view, container: container)
        
        /// Set UI  layouts
        mapImageView.setMapImage(view: container, image: mapImageView)
        cityNameLabel.setCityName(view: container, image: mapImageView, label: cityNameLabel)
        currentDateLabel.setCurrentDate(view: container, image: mapImageView, label: currentDateLabel)
        locationImageView.setLocationImage(view: container, image: locationImageView)
        
        /// Configure UI
        mapImageView.tintColor = .white
        locationImageView.tintColor = .white
        mapImageView.image = SFSymbols.map
        locationImageView.image = SFSymbols.location
    }
    
    private func updateUI() {
        self.cityNameLabel.text = "Kyiv"
        self.currentDateLabel.text = "December 03, 2023"
    }
}

extension TopNameViewController {
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
