//
//  RotatableViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 19.02.2023.
//

import UIKit

class RotatableViewController: UIViewController {
    
    var container = UIView()

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        let isPortrait = UIDevice.current.orientation.isPortrait
        
        /// Change constraints when device rotating has been changed
        container.snp.updateConstraints { make in
            make.leading.equalTo(isPortrait ? 0 : 60)
            make.trailing.equalTo(isPortrait ? 0 : -60)
        }
    }
}
