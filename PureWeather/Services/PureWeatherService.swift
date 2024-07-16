//
//  WeatherKitService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//



import WeatherKit
import CoreLocation


class PureWeatherService {
    private init() {}
    
    static func shared() -> PureWeatherService {
        return PureWeatherService()
    }
    
    func updateWeather() async {
        
    }
    
    func getWeather() async {
        let syracuse = CLLocation(latitude: 43, longitude: -76)
        
        do {
            let weatherService = WeatherService()
            let weather = try await weatherService.weather(for: syracuse)
            print(type(of: weather))
            print(weather.dailyForecast)
            // Handle the weather data here
        } catch {
            // Handle the error here
            print("Failed to get weather: \(error)")
        }
    }
}



