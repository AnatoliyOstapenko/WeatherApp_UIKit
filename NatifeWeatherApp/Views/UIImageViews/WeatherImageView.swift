//
//  WeatherImageView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class WeatherImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image = UIImage(systemName: "cloud.sun")
        tintColor = .label
        clipsToBounds = true
        contentMode = .scaleAspectFit
    }
    
    func setImage(avatar: String?) {
//        NetworkManager.shared.downloadImage(url: avatar ?? ImageNames.placeholder) { [weak self] image in
//            DispatchQueue.main.async { self?.image = image }
//        }
    }

}
