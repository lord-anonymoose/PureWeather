//
//  WeatherKitService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//



import WeatherKit
import CoreLocation


final class PureWeatherService {
    private init() {}
    
    static func shared() -> PureWeatherService {
        return PureWeatherService()
    }
    
    func getWeather() async -> Weather? {
        let syracuse = CLLocation(latitude: 43, longitude: -76)
        
        do {
            let weatherService = WeatherService()
            let weather = try await weatherService.weather(for: syracuse)
            return weather
        } catch {
            print("Failed to get weather: \(error)")
            return nil
        }
    }
}



