//
//  ForecastTableViewCell.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 18.02.2023.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    private let dayLabel = WeatherLabel(textAlignment: .left, fontSize: 18, weight: .medium)
    private let tempContainer = UIStackView()
    private let minTempLabel = WeatherLabel(fontSize: 22, weight: .medium)
    private let maxTempLabel = WeatherLabel(fontSize: 22, weight: .medium)
    private let weatherImageView = WeatherImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        dayLabel.text = "Mon"
        minTempLabel.text = "12 º / "
        maxTempLabel.text = "18 º"
        backgroundColor = .clear
        setDayLabel(view: self, label: dayLabel)
        setWeatherImageView(view: self, imageView: weatherImageView)
        setTempContainer(view: self, container: tempContainer)
        tempContainer.addAllSubbviews(minTempLabel, maxTempLabel)
    }
}
