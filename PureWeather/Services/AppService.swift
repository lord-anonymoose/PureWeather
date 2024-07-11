//
//  AppService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import Foundation


class AppService {
    private init() {}
    
    enum appSetting {
        case temperature
        case windSpeed
        case timeFormat
        case notifications
        
        var label: String {
            switch self {
            case .temperature:
                return String(localized: "Temperature")
            case .windSpeed:
                return String(localized: "Wind Speed")
            case .timeFormat:
                return String(localized: "Time Format")
            case .notifications:
                return String(localized: "Notifications")
            }
        }
        
        var values: [String] {
            switch self {
            case .temperature:
                return [String(localized: "С"), String(localized: "F")]
            case .windSpeed:
                return [String(localized: "m/s"), String(localized: "mi/s")]
            case .timeFormat:
                return [String(localized: "12h"), String(localized: "24h")]
            case .notifications:
                return [String(localized: "On"), String(localized: "Off")]
            }
        }
    }

    static func shared() -> AppService {
        return AppService()
    }
    
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "PureWeatherLaunched") {
            return false
        } else {
            return true
        }
    }
    
    func setLaunched() {
        let defaults = UserDefaults.standard
        
        defaults.set(true, forKey: "PureWeatherLaunched")
    }
}
