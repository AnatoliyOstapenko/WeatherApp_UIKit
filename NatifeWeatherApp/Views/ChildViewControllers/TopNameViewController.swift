//
//  TopNameViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 12.02.2023.
//

import UIKit

protocol TopCoordinatesProtocol: AnyObject {
    func coordinates(lat: Double, lon: Double)
    func requestLocation()
}

class TopNameViewController: RotatableViewController {

    var coordinator: CoordinatorProtocol?
    weak var delegate: TopCoordinatesProtocol?
    private var weather: [WeatherData]?
    
    /// Private UI properties
    private let mapImageView = UIImageView()
    private let locationButton = TopLocationButton(image: SFSymbols.pin)
    private let cityNameLabel = WeatherLabel(textAlignment: .left, fontSize: 28, weight: .bold)
    private let currentDateLabel = WeatherLabel(textAlignment: .left, fontSize: 18, weight: .medium)
    
    init(weather: [WeatherData], cityName: String, delegate: TopCoordinatesProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.weather = weather
        self.cityNameLabel.text = cityName.capitalizingFirstLetter()
        self.delegate = delegate
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
            UIAction(title: ActionTitle.findCity, image: SFSymbols.glass, handler: menuHandler),
        ])
        locationButton.menu = menu
    }
    
    private func menuHandler(action: UIAction) {
        switch action.title {
        case ActionTitle.currentLocation: self.delegate?.requestLocation()
        case ActionTitle.findCity: coordinator?.createMapView(viewController: self)
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
        self.currentDateLabel.text = self.weather?.first?.date.topDay ?? "no date"
    }
}

extension TopNameViewController: MapCoordinatesProtocol {
    func coordinates(lat: Double, lon: Double) {
        self.delegate?.coordinates(lat: lat, lon: lon)
    }
}




