//
//  AppService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import Foundation


class AppService {
    private init() {}

    static func shared() -> AppService {
        return AppService()
    }
    
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "PureWeatherLaunched") {
            return false
        } else {
            defaults.set(true, forKey: "PureWeatherLaunched")
            return true
        }
    }    
}
