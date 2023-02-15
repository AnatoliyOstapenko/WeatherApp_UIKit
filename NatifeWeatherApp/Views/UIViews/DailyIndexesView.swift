//
//  DailyIndexesView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

enum IndexType { case temperature, humidity, wind }

class DailyIndexesView: UIView {
    
    let dailyIndexesContainer = UIStackView()
    let symbolImageView = UIImageView()
    let indexLabel = WeatherSecondaryLabel(fontSize: 18)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        dailyIndexesContainer.setDailyIndexesContainer(view: self, container: dailyIndexesContainer)
        dailyIndexesContainer.addAllSubbviews(symbolImageView, indexLabel)
        symbolImageView.tintColor = .label
        indexLabel.tintColor = .label
        symbolImageView.contentMode = .center
    }
    
    func set(indexImage: IndexType, indexText: String) {
        switch indexImage {
        case .temperature:
            symbolImageView.image = SFSymbols.temperature
        case .humidity:
            symbolImageView.image = SFSymbols.humidity
        case .wind:
            symbolImageView.image = SFSymbols.wind
        }
        indexLabel.text = indexText
    }
}

