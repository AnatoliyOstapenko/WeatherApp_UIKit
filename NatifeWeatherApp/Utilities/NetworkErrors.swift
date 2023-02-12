//
//  NetworkErrors.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import Foundation

enum NetworkErrors: String, Error {
    
    case invalidURL = "It seems that URL adress appears to be invalid"
    case invalidResponse = "It seems that response appears to be invalid, check response status code"
    case invalidData = "It seems that data appears to be invalid"
    case invalidTask = "URL Session unable to complete, check internet connection"
    case unableToComplete = "Check the menu model, there is a grammatical error"
}
