//
//  WeatherCoordinator.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

protocol CoordinatorProtocol {
    var navController: UINavigationController { get set }
    func start()
}

class WeatherCoordinator: CoordinatorProtocol {
    var navController: UINavigationController
    init(navController: UINavigationController) {self.navController = navController }

    func start() {
        let view = WeatherMainScreen()
        let networkManager = NetworkManager()
        let presenter = WeatherPresenter(view: view, networkManager: networkManager)

        view.presenter = presenter
        view.coordinator = self
        navController.pushViewController(view, animated: true)
    }
}
