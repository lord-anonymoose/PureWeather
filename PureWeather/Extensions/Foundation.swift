//
//  Foundation.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 17.07.2024.
//

import Foundation


extension Double {
    func formattedTemperature() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return result
    }
    
    func formattedTemperatureCelcius() -> String {
        var result = self.formattedTemperature()
        result.append(" °C")
        return result
    }
    
    func formattedTemperatureFahrenheit() -> String {
        let temperature = self * 1.8 + 32
        var result = temperature.formattedTemperature()
        result.append(" °F")
        return result
    }
}
