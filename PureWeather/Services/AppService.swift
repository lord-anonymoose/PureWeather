//
//  AppService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import Foundation


final class AppService {
    private init() {}
    
    static func shared() -> AppService {
        return AppService()
    }

    let defaults = UserDefaults.standard
    
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
                return ["С°", "F°"]
            case .windSpeed:
                return [String(localized: "m/s"), String(localized: "mi/s")]
            case .timeFormat:
                return [String(localized: "24h"), String(localized: "12h")]
            case .notifications:
                return [String(localized: "On"), String(localized: "Off")]
            }
        }
    }
    
    // Is the app launched for the first time
    // Used for showing OnboardingViewController and PrivacyViewController
    func isFirstLaunch() -> Bool {
        if defaults.bool(forKey: "PureWeatherLaunched") {
            return false
        } else {
            return true
        }
    }
    
    func setLaunched() {
        defaults.set(true, forKey: "PureWeatherLaunched")
    }
    
    
    
    // App Settings
    func isFahrenheit() -> Bool {
        if defaults.bool(forKey: "PureWeather.settings.isFahrenheit") {
            return true
        } else {
            return false
        }
    }
    
    func setFahrenheit(_ setting: Bool) {
        defaults.set(setting, forKey: "PureWeather.settings.isFahrenheit")
    }
    
    func is12hFormat() -> Bool {
        if defaults.bool(forKey: "PureWeather.settings.is12hFormat") {
            return true
        } else {
            return false
        }
    }
    
    func set12hFormat(_ setting: Bool) {
        defaults.set(setting, forKey: "PureWeather.settings.is12hFormat")
    }
    
    func isAmericanSystem() -> Bool {
        if defaults.bool(forKey: "PureWeather.settings.isAmericanSystem") {
            return true
        } else {
            return false
        }
    }
    
    func setAmericanSystem(_ setting: Bool) {
        defaults.set(setting, forKey: "PureWeather.settings.isAmericanSystem")
    }
    
    
}
