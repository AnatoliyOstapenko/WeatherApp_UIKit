//
//  NetworkManager.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import Foundation

import UIKit

protocol NetworkManagerProtocol {
    func weatherByLocation(lat: Double, lon: Double, completion: @escaping(Result<WeatherModel, NetworkErrors>) -> Void)
    func weatherByCityName(cityName: String, completion: @escaping(Result<WeatherModel, NetworkErrors>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func weatherByLocation(lat: Double, lon: Double, completion: @escaping(Result<WeatherModel, NetworkErrors>) -> Void) {
        let urlString = Constants.baseURLString + Constants.key + "&lat=\(lat)&lon=\(lon)"
        print(urlString)
        
        request(url: urlString, expecting: WeatherModel.self, completion: completion)
    }
    
    func weatherByCityName(cityName: String, completion: @escaping(Result<WeatherModel, NetworkErrors>) -> Void) {
        let urlString = Constants.baseURLString + Constants.key + "&q=\(cityName.lowercased())"
        print(urlString)
        
        request(url: urlString, expecting: WeatherModel.self, completion: completion)
    }
    
    private func request<T: Codable>(url: String, expecting: T.Type, completion: @escaping(Result<T, NetworkErrors>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidTask))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            print("Status code of HTTP response: \(response.statusCode)")
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(expecting, from: data)
                completion(.success(weatherData))
                
            } catch { completion(.failure(.unableToComplete)) }
        }
        task.resume()
    }
    
    func downloadImage(icon: String, completion: @escaping(UIImage?) -> Void) {
        let imageURL = Constants.baseIconURL + icon + "@2x.png"
        guard let url = URL(string: imageURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else { return }
            completion(image)
        }
        task.resume()
    }
}
