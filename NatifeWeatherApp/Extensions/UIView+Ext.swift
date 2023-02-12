//
//  UIView+Ext.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit
import SnapKit

extension UIView {
    
    // MARK: - WeatherMainScreen Layout
    
    func setMainStackVeiw(view: UIView, stackView: UIStackView) {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
    // MARK: - TopNameViewController Layout
    
    func setMapImage(view: UIView, image: UIImageView) {
        view.addSubview(image)
        image.tintColor = .label
        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(5)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    func setCityName(view: UIView, image: UIImageView, label: UILabel) {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(image)
            make.leading.equalTo(image.snp.trailing).offset(5)
            make.height.equalTo(image)
            make.width.equalTo(200)
        }
    }
    
    func setCurrentDate(view: UIView, image: UIImageView, label: UILabel) {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.leading.equalTo(image.snp.leading)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }        
    }
    
    func setLocationImage(view: UIView, image: UIImageView) {
        view.addSubview(image)
        image.tintColor = .label
        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    

}

extension UIStackView {
    func addAllSubbviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
