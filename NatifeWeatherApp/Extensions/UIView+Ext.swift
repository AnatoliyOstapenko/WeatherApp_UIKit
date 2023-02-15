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
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setContentView(view: UIView, content: UIView) {
        view.addSubview(content)

        content.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(600)
        }
    }
    
    func setTopNameViewContainer(view: UIView, container: UIView) {
        view.addSubview(container)
        container.backgroundColor = .systemGray
//        container.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            container.heightAnchor.constraint(equalToConstant: 150)
//        ])
        container.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    func setDailyWeatherViewContainer(view: UIView, topcontainer: UIView, container: UIView) {
        view.addSubview(container)
        container.backgroundColor = .systemGray2
//        container.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            container.topAnchor.constraint(equalTo: topcontainer.bottomAnchor),
//            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            container.heightAnchor.constraint(equalToConstant: 150)
//        ])
        container.snp.makeConstraints { make in
            make.top.equalTo(topcontainer.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func setHourlyWeatherViewContainer(view: UIView, topcontainer: UIView, container: UIView) {
        
    }
    
    func setForecastWeatherViewContainer(view: UIView, topcontainer: UIView, container: UIView) {
        
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
    
    // MARK: - DailyWeatherViewController Layout
    
    func setDailyWeatherImageView(view: UIView, imageView: UIImageView) {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(180)
        }
    }
    
    func setDailyTemperatureContainerView(view: UIView, imageView: UIImageView , container: UIView) {
        view.addSubview(container)
        container.backgroundColor = .systemPink
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
    }
    
    func setDailyHumidityContainerView(view: UIView, imageView: UIImageView , container: UIView) {
        view.addSubview(container)
        container.backgroundColor = .systemPink
        
        container.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
    }
    
    func  setDailyWindContainerView(view: UIView, imageView: UIImageView , container: UIView) {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(180)
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
        container.backgroundColor = .systemGray
        
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    func setLabelContainerView(container: UIStackView, leftLabel: UILabel, rightLabel: UILabel) {
        container.addAllSubbviews(leftLabel, rightLabel)
        leftLabel.backgroundColor = .brown

        container.axis = .horizontal
        container.distribution = .fillEqually
        container.backgroundColor = .systemPink
        
        container.snp.makeConstraints { make in
            make.width.equalTo(140)
        }
        
    }
}

extension UIStackView {
    func addAllSubbviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
