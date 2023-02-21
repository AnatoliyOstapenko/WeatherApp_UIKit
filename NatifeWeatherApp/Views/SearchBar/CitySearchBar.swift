//
//  CitySearchBar.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 19.02.2023.
//

import UIKit

class CitySearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        /// configure searchBar
        searchTextField.backgroundColor = .white
        barStyle = .black
        searchTextField.clearButtonMode = .never
        searchTextField.leftViewMode = .never
        let textField = value(forKey: "searchField") as? UITextField
        textField?.textColor = .black
        placeholder = "Виберіть місто"
        sizeToFit()
    }
}
