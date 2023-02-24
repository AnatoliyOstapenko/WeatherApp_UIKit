//
//  TopLocationButton.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 19.02.2023.
//

import UIKit

class TopLocationButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage?) {
        self.init(frame: .zero)
        configuration?.image = image
    }
    
    private func configureUI() {
        configuration = UIButton.Configuration.plain()
        configuration?.buttonSize = .large
        tintColor = .white
        showsMenuAsPrimaryAction = true
    }  
}
