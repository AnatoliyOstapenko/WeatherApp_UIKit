//
//  HourlyWeatherCollectionCell.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 18.02.2023.
//

import UIKit

class HourlyWeatherCollectionCell: UICollectionViewCell {
    
    private let hourLabel = WeatherLabel(fontSize: 16, weight: .medium)
    private let weatherImage = WeatherImageView(frame: .zero)
    private let temperatureLabel = WeatherLabel(fontSize: 18, weight: .medium)
    private let bottomContainer = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        hourLabel.text = "22ºº"
        temperatureLabel.text = "18º"
        
        setHourLabel(view: self, label: hourLabel)
        setBottomContainer(view: self, container: bottomContainer)
        bottomContainer.addAllSubbviews(weatherImage, temperatureLabel)
        weatherImage.contentMode = .center
    }
    
    func updateCollectionCellUI() {
        
    }
}
