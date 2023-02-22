//
//  WeatherImageView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class WeatherImageView: UIImageView {
    
    lazy var presenter = ImagePresenter(view: self, networkManager: NetworkManager())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image = UIImage(systemName: "cloud.sun")
        tintColor = .white
        contentMode = .scaleAspectFill
    }
    
    func getIcon(imageString: String?) {
        presenter.getImage(imageString: imageString ?? "")
    }
}

extension WeatherImageView: ImageViewProtocol {
    func setImage(image: UIImage) {
        self.image = image
    }
}
