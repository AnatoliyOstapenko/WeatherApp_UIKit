//
//  WeatherSecondaryLabel.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class WeatherLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment = .center,
                     fontSize: CGFloat,
                     weight: UIFont.Weight,
                     color: UIColor = .white) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        font = .systemFont(ofSize: fontSize, weight: weight)
        textColor = color
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.3
        lineBreakMode = .byTruncatingTail
    }

}
