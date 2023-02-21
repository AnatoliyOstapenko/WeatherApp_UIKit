//
//  CityTextField.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 19.02.2023.
//

import UIKit

class CityTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(vc: UIViewController, returnKeyType: UIReturnKeyType) {
        self.init(frame: .zero)
        delegate = vc as? any UITextFieldDelegate
        self.returnKeyType = returnKeyType
    }
    
    private func configure() {
//        layer.cornerRadius = 10
//        layer.borderColor = UIColor.darkGray.cgColor
//        layer.borderWidth = 3
        textAlignment = .left
        textColor = .black
        backgroundColor = .white
        
        font = .preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 7
//        enablesReturnKeyAutomatically = true
        translatesAutoresizingMaskIntoConstraints = false
    }

}
