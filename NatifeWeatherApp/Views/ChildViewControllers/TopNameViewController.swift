//
//  TopNameViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

class TopNameViewController: RotatableViewController {

    var coordinator: CoordinatorProtocol?
    private var weather: [WeatherData]?

    private let mapImageView = UIImageView()
    private let locationButton = TopLocationButton()
    private let cityNameLabel = WeatherLabel(textAlignment: .left, fontSize: 28, weight: .bold)
    private let currentDateLabel = WeatherLabel(textAlignment: .left, fontSize: 18, weight: .medium)
    
    init(weather: [WeatherData], cityName: String) {
        super.init(nibName: nil, bundle: nil)
        self.weather = weather
        self.cityNameLabel.text = cityName.capitalizingFirstLetter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateUI()
        setButtonMenu()
    }

    private func setButtonMenu() {
        let menu = UIMenu(title: "", children: [
            UIAction(title: ActionTitle.currentLocation, image: SFSymbols.location, handler: menuHandler),
            UIAction(title: ActionTitle.findLocation, image: SFSymbols.locationGlass, handler: menuHandler),
            UIAction(title: ActionTitle.findCity, image: SFSymbols.glass, handler: menuHandler),
        ])
        locationButton.menu = menu
    }
    
    private func menuHandler(action: UIAction) {
        switch action.title {
        case ActionTitle.currentLocation: print("01")
        case ActionTitle.findLocation: print("02")
        case ActionTitle.findCity: self.coordinator?.goToCityScreen()
        default: break
        }
    }
    
    private func configureUI() {
        /// Set generic container to change constraints when rotating the iPhone
        container.setGenericContainer(view: view, container: container)
        /// Set UI  layouts
        mapImageView.setMapImage(view: container, image: mapImageView)
        cityNameLabel.setCityName(view: container, image: mapImageView, label: cityNameLabel)
        currentDateLabel.setCurrentDate(view: container, image: mapImageView, label: currentDateLabel)
        locationButton.setLocationButton(view: container, button: locationButton)
        
        /// Configure static map view
        mapImageView.tintColor = .white
        mapImageView.image = SFSymbols.map
    }
    
    private func updateUI() {
        self.currentDateLabel.text = self.weather?.first?.date ?? "no date"
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

