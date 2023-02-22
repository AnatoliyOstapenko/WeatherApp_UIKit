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
    
    func updateForecastCell(weather: WeatherData, icon: String) {
        dayLabel.text = weather.date.dayOfWeek
        minTempLabel.text = "\(weather.tempMin) "
        maxTempLabel.text = "/ \(weather.tempMax)"
        weatherImageView.getIcon(imageString: icon)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        weatherImageView.tintColor = selected ? WeatherColor.darkBlue : .black
        dayLabel.textColor = selected ? WeatherColor.darkBlue : .black
        minTempLabel.textColor = selected ? WeatherColor.darkBlue : .black
        maxTempLabel.textColor = selected ? WeatherColor.darkBlue : .black
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
    
    private func configureUI() {
        setDayLabel(view: self, label: dayLabel)
        setWeatherImageView(view: self, imageView: weatherImageView)
        setTempContainer(view: self, container: tempContainer)
        tempContainer.addAllSubbviews(minTempLabel, maxTempLabel)
    }
}


