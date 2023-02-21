//
//  BaseTypes+Ext.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 21.02.2023.
//

import Foundation

extension Int {
    
    var topDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        let date = Date(timeIntervalSince1970: Double(self))
        return dateFormatter.string(from: date)
    }
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: Double(self))
        let string = dateFormatter.string(from: date)
        return string.prefix(3).capitalized /// cut week day to 3 characters
    }
    
    var superscripted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: Double(self))
        let string = dateFormatter.string(from: date)
        let superscriptZero = "\u{0323}\u{0323}"
        return string.replacingOccurrences(of: ":", with: ":" + superscriptZero)
    }
}

extension Double {
    var temperatured: String {String(format: "%.0fº", self)}
}

extension String {
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: Double(self) ?? 0)
        let string = dateFormatter.string(from: date)
        return string.prefix(3).capitalized /// cut week day to 3 characters
    }
}
