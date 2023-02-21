//
//  CityTableViewCell.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 19.02.2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    private let cityLabel = WeatherLabel(textAlignment: .center, fontSize: 22, weight: .medium, color: .black)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(cityLabel)
        backgroundColor = .white
        cityLabel.text = "CityName"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityLabel.frame = contentView.bounds
    }
}
