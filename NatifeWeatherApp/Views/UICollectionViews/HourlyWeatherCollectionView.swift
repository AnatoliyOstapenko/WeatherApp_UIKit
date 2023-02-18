//
//  HourlyWeatherCollectionView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 18.02.2023.
//

import UIKit

class HourlyWeatherCollectionView: UICollectionView {

    private var weather: [WeatherList] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        register(HourlyWeatherCollectionCell.self,
                 forCellWithReuseIdentifier: String(describing: HourlyWeatherCollectionCell.self))
        delegate = self
        dataSource = self
    }
}

// MARK: - Delegate & DataSource

extension HourlyWeatherCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourlyWeatherCollectionCell.self), for: indexPath) as! HourlyWeatherCollectionCell
        
        return cell
    }
}

// MARK: - Resize collection cell

extension HourlyWeatherCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CGSize(width: Constants.cellItemWidth, height: frame.height)
    }
}

