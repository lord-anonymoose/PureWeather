//
//  StorageService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 16.07.2024.
//

import Foundation
import WeatherKit
import RealmSwift
import UIKit

final class HourlyWeather: Object {
    @objc dynamic var temperature: Double = 0
    @objc dynamic var condition: String = ""
    @objc dynamic var wind: Double = 0
    @objc dynamic var precipitation: Double = 0
    @objc dynamic var humidity: Double = 0
    @objc dynamic var uvIndex: Int = 0
    @objc dynamic var icon: String = ""
    @objc dynamic var date: Date = Date()
}

final class DailyWeather: Object {
    let day = List<HourlyWeather>()
}

final class CityWeather: Object {
    let forecast = List<DailyWeather>()
}

final class StorageService {
    private init() {}
    
    static func shared() -> StorageService {
        return StorageService()
    }
    
    func makeWeatherStored(weather: Weather) {
        for forecast in weather.hourlyForecast {
            let temperature = forecast.temperature
            let condition = forecast.condition.rawValue
            let wind = forecast.wind
            let precipitation = forecast.precipitation
            let humidity = forecast.humidity
            let uvIndex = forecast.uvIndex
            let icon = "UNKNOWN"
        }
    }
    
    func getWeatherBackup() {
        do {
            let realm = try Realm()
            let quotes = realm.objects(CityWeather.self)
        } catch {
            print("Failed to fetch quotes from Realm: \(error)")
        }
    }
}

