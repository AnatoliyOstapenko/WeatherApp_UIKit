//
//  DailyIndexesView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

enum IndexType { case temperature, humidity, wind }

class DailyIndexesView: UIView {
    
    private let dailyIndexesContainer = UIStackView()
    private let symbolImageView = UIImageView()
    private let labelContainerView = UIStackView()
    private let leftIndexLabel = WeatherSecondaryLabel(fontSize: 18)
    private let rightIndexLabel = WeatherSecondaryLabel(fontSize: 18)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        dailyIndexesContainer.setDailyIndexesContainer(view: self, container: dailyIndexesContainer)
        dailyIndexesContainer.addAllSubbviews(symbolImageView, labelContainerView)
        labelContainerView.setLabelContainerView(container: labelContainerView, leftLabel: leftIndexLabel, rightLabel: rightIndexLabel)
        symbolImageView.tintColor = .label
        leftIndexLabel.tintColor = .label
        rightIndexLabel.tintColor = .label
        symbolImageView.contentMode = .center
    }
    
    func set(indexImage: IndexType, leftIndexText: String, rightIndexText: String? = nil) {
        switch indexImage {
        case .temperature:
            symbolImageView.image = SFSymbols.temperature
        case .humidity:
            symbolImageView.image = SFSymbols.humidity
        case .wind:
            symbolImageView.image = SFSymbols.wind
        }
        leftIndexLabel.text = leftIndexText
        rightIndexLabel.text = rightIndexText
    }
}

