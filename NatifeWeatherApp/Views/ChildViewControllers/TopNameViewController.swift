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
    private let cityNameLabel = WeatherTitleLabel(textAligment: .left, fontSize: 28)
    private let currentDateLabel = WeatherSecondaryLabel(fontSize: 18)
    private let locationImageView = UIImageView()
    
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
    }
    
    private func updateUI() {
        self.mapImageView.image = SFSymbols.map
        self.cityNameLabel.text = "Kyiv"
        self.currentDateLabel.text = "December 03, 2023"
        self.locationImageView.image = SFSymbols.location
    }


}
