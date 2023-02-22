//
//  ImagePresenter.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 22.02.2023.
//

import UIKit

protocol ImageViewProtocol: AnyObject {
    func setImage(image: UIImage)
}

protocol ImagePresenterProtocol: AnyObject {
    init (view: ImageViewProtocol, networkManager: NetworkManagerProtocol)
    func getImage(imageString: String)
}

class ImagePresenter: ImagePresenterProtocol {
    weak var view: ImageViewProtocol?
    private let networkManager: NetworkManagerProtocol
    
    required init(view: ImageViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getImage(imageString: String) {
        networkManager.downloadImage(imageString: imageString) { [weak self] image in
            guard let self = self, let image = image else { return }
            DispatchQueue.main.async {
                self.view?.setImage(image: image)
            }
        }
    }
}
