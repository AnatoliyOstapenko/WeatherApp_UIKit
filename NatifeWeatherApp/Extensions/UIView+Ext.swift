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
    
    func setScrollView(view: UIView, scrollView: UIView) {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view)
        }
    }
    
    func setContentView(view: UIView, content: UIView) {
        view.addSubview(content)

        content.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(740)
        }
    }
    
    func setTopNameContainer(view: UIView, container: UIView) {
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    func setDailyWeatherContainer(view: UIView, topcontainer: UIView, container: UIView) {
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.top.equalTo(topcontainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    func setHourlyWeatherContainer(view: UIView, topcontainer: UIView, container: UIView) {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.top.equalTo(topcontainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
    }
    
    func setForecastWeatherContainer(superview: UIView, view: UIView, topcontainer: UIView, container: UIView) {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.top.equalTo(topcontainer.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(superview.snp.bottom)
        }
    }

    
    // MARK: - TopNameViewController Layout
    
    func setGenericContainer(view: UIView, container: UIView) {
        view.addSubview(container)
        container.backgroundColor = .clear
        
        container.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setMapImage(view: UIView, image: UIImageView) {
        view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(5)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.height.equalTo(30)
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
    
    func setLocationButton(view: UIView, button: UIButton) {
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.width.height.equalTo(30)
        }
    }
    
    // MARK: - DailyWeatherViewController Layout
    
    func setWeatherImage(view: UIView, imageView: UIImageView) {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(180)
        }
    }
    
    func setTemperatureContainer(view: UIView, container: UIView) {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(170)
            make.height.equalTo(30)
        }
    }
    
    func setHumidityContainer(view: UIView, imageView: UIImageView , container: UIView) {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(170)
            make.height.equalTo(30)
        }
    }
    
    func  setWindContainer(view: UIView, container: UIView) {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(170)
            make.height.equalTo(30)
        }
    }
    
    func setDailyView(container: UIView, subview: UIView) {
        container.addSubview(subview)
        
        subview.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(container)
        }
    }
    
    // MARK: - DailyIndexesView Layout
    
    func setDailyIndexesContainer(view: UIView, container: UIStackView) {
        view.addSubview(container)
        container.axis = .horizontal
        container.distribution = .fill
        
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    func setLabelContainerView(container: UIStackView) {
        container.axis = .horizontal
        container.distribution = .fill
        container.spacing = 5
        
        container.snp.makeConstraints { make in
            make.width.equalTo(140)
        }
    }
    
    // MARK: - HourlyWeatherCollectionCell Layout
    
    func setHourLabel(view: UIView, label: UILabel) {
        view.addSubview(label)
    
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setBottomContainer(view: UIView, container: UIStackView, image: UIImageView) {
        view.addSubview(container)
        container.axis = .vertical
        container.distribution = .fill
        container.spacing = 5
        
        container.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    // MARK: - ForecastTableViewCell Layout

    func setTempContainer(view: UIView, container: UIStackView) {
        view.addSubview(container)
        container.axis = .horizontal
        container.distribution = .fill

        container.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func setDayLabel(view: UIView, label: UILabel) {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(80)
        }
    }
    
    func setWeatherImageView(view: UIView, imageView: UIImageView) {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(30)
        }
    }
    
    // MARK: - WeatherMapViewController Layout
    
    func setWeatherMapElements(view: UIView, subView: UIView) {
        view.addSubview(subView)
        
        subView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setMapButton(view: UIView, button: UIButton) {
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.height.equalTo(30)
        }
    }
}

// MARK: - Add views to StackView at the same time

extension UIStackView {
    func addAllSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}

// MARK: - Shadow for row of Hourly sell

extension UIView {
    func addShadow(){
        self.backgroundColor = .white
        self.layer.shadowColor = WeatherColor.darkBlue.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0)
    }
}
