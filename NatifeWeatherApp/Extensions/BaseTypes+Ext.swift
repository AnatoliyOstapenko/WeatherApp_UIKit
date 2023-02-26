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
        return string.prefix(3).capitalized
    }
    
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "HH"
        let date = Date(timeIntervalSince1970: Double(self))
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func directionToSymbol(_ direction: Double) -> String {
        switch direction {
        case 0...22.5, 337.5...360:
            return "\u{2191}"
        case 22.5...67.5:
            return "\u{2197}"
        case 67.5...112.5:
            return "\u{2192}"
        case 112.5...157.5:
            return "\u{2198}"
        case 157.5...202.5:
            return "\u{2193}"
        case 202.5...247.5:
            return "\u{2199}"
        case 247.5...292.5:
            return "\u{2190}"
        case 292.5...337.5:
            return "\u{2196}"
        default:
            return ""
        }
    }
}

extension Double {
    var temperatured: String {String(format: "%.0fº", self)}
    var roundSpeed: String {String(format: "%.0fm/s", self)}

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

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
