//
//  DailyIndexesView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

enum IndexInfoType { case temperature, humidity, wind }

class DailyIndexesView: UIView {
    
    let symbolImageView = UIImageView()
    let indexLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {

    }
    
    func set(itemInfoType: IndexInfoType, index: String) {
        
        switch itemInfoType {
        case .temperature:
            symbolImageView.image = SFSymbols.temperature
            indexLabel.text = "21 C"
        case .humidity:
            symbolImageView.image = SFSymbols.humidity
            indexLabel.text = "33 %"
        case .wind:
            symbolImageView.image = SFSymbols.wind
            indexLabel.text = "5 m/s"
        }
    }
}

