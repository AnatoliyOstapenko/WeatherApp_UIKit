//
//  ForecastTableViewCell.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 18.02.2023.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    private let dayLabel = WeatherLabel(textAlignment: .left, fontSize: 18, weight: .medium, color: .black)
    private let tempContainer = UIStackView()
    private let minTempLabel = WeatherLabel(fontSize: 22, weight: .medium, color: .black)
    private let maxTempLabel = WeatherLabel(fontSize: 22, weight: .medium, color: .black)
    private let weatherImageView = WeatherImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        handleSelecting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        dayLabel.text = "Mon"
        minTempLabel.text = "12 º / "
        maxTempLabel.text = "18 º"
        
        setDayLabel(view: self, label: dayLabel)
        setWeatherImageView(view: self, imageView: weatherImageView)
        setTempContainer(view: self, container: tempContainer)
        tempContainer.addAllSubbviews(minTempLabel, maxTempLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        weatherImageView.tintColor = selected ? UIColor(hex: Constants.darkBlue) : .black
        dayLabel.textColor = selected ? UIColor(hex: Constants.darkBlue) : .black
        minTempLabel.textColor = selected ? UIColor(hex: Constants.darkBlue) : .black
        maxTempLabel.textColor = selected ? UIColor(hex: Constants.darkBlue) : .black
    }

    private func handleSelecting() {
        let initialView = UIView(frame: bounds)
        initialView.backgroundColor = .white
        backgroundView = initialView

        let selectedView = UIView(frame: bounds)
        selectedView.addShadow()
        selectedView.tintColor = .red
        selectedBackgroundView = selectedView
    }
}


