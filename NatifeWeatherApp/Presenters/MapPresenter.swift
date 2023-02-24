//
//  MapPresenter.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 24.02.2023.
//

import UIKit

protocol MapViewProtocol: AnyObject {
    func setImage(city: String)
}

protocol MapViewPresenter: AnyObject {
    init (view: MapViewProtocol, networkManager: NetworkManagerProtocol)
    func getImage(imageString: String)
}

//class MapPresenter: MapViewPresenter {
//    weak var view: MapViewProtocol?
//    private let networkManager: NetworkManagerProtocol
//    
//    required init(view: MapViewProtocol, networkManager: NetworkManagerProtocol) {
//        self.view = view
//        self.networkManager = networkManager
//    }
//    
//    func getCoordinates(city: String) {
//        
//    }
//}

