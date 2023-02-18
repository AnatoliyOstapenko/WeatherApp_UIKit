//
//  TopNameViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class TopNameViewController: UIViewController {
    
    private var weather: WeatherList?
    
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
        mapImageView.setMapImage(view: view, image: mapImageView)
        cityNameLabel.setCityName(view: view, image: mapImageView, label: cityNameLabel)
        currentDateLabel.setCurrentDate(view: view, image: mapImageView, label: currentDateLabel)
        locationImageView.setLocationImage(view: view, image: locationImageView)
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
