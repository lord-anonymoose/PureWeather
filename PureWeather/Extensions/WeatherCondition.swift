//
//  WeatherCondition.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 16.07.2024.
//

import WeatherKit
import UIKit

extension WeatherCondition {
    var image: UIImage {
        switch self {
        case .blizzard:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor, .snowflakeColor])
            return UIImage(systemName: "wind.snow")!.withConfiguration(config)
            
        case .blowingDust:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor])
            return UIImage(systemName: "wind")!.withConfiguration(config)
            
        case .blowingSnow:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor, .snowflakeColor])
            return UIImage(systemName: "wind.snow")!.withConfiguration(config)
            
        case .breezy:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor])
            return UIImage(systemName: "wind")!.withConfiguration(config)
            
        case .clear:
            let config = UIImage.SymbolConfiguration(paletteColors: [.sunColor])
            return UIImage(systemName: "sun.max.fill")!.withConfiguration(config)
            
        case .cloudy:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor, .cloudColor])
            return UIImage(systemName: "smoke.fill")!.withConfiguration(config)
            
        case .drizzle:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .raindropColor])
            return UIImage(systemName: "cloud.drizzle.fill")!.withConfiguration(config)
            
        case .flurries:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .snowflakeColor])
            return UIImage(systemName: "cloud.snow.fill")!.withConfiguration(config)
            
        case .foggy:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor, .cloudColor])
            return UIImage(systemName: "cloud.fog.fill")!.withConfiguration(config)
            
        case .freezingDrizzle:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .raindropColor])
            return UIImage(systemName: "cloud.sleet.fill")!.withConfiguration(config)
            
        case .freezingRain:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .raindropColor])
            return UIImage(systemName: "cloud.sleet.fill")!.withConfiguration(config)
            
        case .frigid:
            let config = UIImage.SymbolConfiguration(paletteColors: [.snowflakeColor, .raindropColor])
            return UIImage(systemName: "thermometer.snowflake")!.withConfiguration(config)
            
        case .hail:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .snowflakeColor])
            return UIImage(systemName: "cloud.hail.fill")!.withConfiguration(config)
            
        case .haze:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor, .cloudColor])
            return UIImage(systemName: "cloud.fog.fill")!.withConfiguration(config)
            
        case .heavyRain:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor, .raindropColor])
            return UIImage(systemName: "cloud.heavyrain.fill")!.withConfiguration(config)
            
        case .heavySnow:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor, .snowflakeColor])
            return UIImage(systemName: "cloud.snow.fill")!.withConfiguration(config)
            
        case .hot:
            let config = UIImage.SymbolConfiguration(paletteColors: [.red, .sunColor, .black])
            return UIImage(systemName: "thermometer.sun.fill")!.withConfiguration(config)
            
        case .hurricane:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor])
            return UIImage(systemName: "hurricane")!.withConfiguration(config)
            
        case .isolatedThunderstorms:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .thunderColor])
            return UIImage(systemName: "cloud.bolt.fill")!.withConfiguration(config)

        case .mostlyClear:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor])
            return UIImage(systemName: "icloud.slash.fill")!.withConfiguration(config)
            
        case .mostlyCloudy:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor])
            return UIImage(systemName: "cloud.fill")!.withConfiguration(config)
            
        case .partlyCloudy:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudColor])
            return UIImage(systemName: "cloud.fill")!.withConfiguration(config)
            
        case .rain:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .raindropColor])
            return UIImage(systemName: "cloud.rain.fill")!.withConfiguration(config)
            
        case .scatteredThunderstorms:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .thunderColor])
            return UIImage(systemName: "cloud.bolt.fill")!.withConfiguration(config)
            
        case .sleet:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .raindropColor, .snowflakeColor])
            return UIImage(systemName: "cloud.sleet.fill")!.withConfiguration(config)
            
        case .smoky:
            let config = UIImage.SymbolConfiguration(paletteColors: [.smokeColor])
            return UIImage(systemName: "smoke.fill")!.withConfiguration(config)
            
        case .snow:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .snowflakeColor])
            return UIImage(systemName: "cloud.snow.fill")!.withConfiguration(config)
            
        case .strongStorms:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor])
            return UIImage(systemName: "wind")!.withConfiguration(config)
            
        case .sunFlurries:
            let config = UIImage.SymbolConfiguration(paletteColors: [.snowflakeColor, .sunColor])
            return UIImage(systemName: "sun.snow.fill")!.withConfiguration(config)
            
        case .sunShowers:
            let config = UIImage.SymbolConfiguration(paletteColors: [.raindropColor, .sunColor])
            return UIImage(systemName: "sun.rain.fill")!.withConfiguration(config)
            
        case .thunderstorms:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor, .thunderColor])
            return UIImage(systemName: "cloud.bolt.fill")!.withConfiguration(config)
            
        case .tropicalStorm:
            let config = UIImage.SymbolConfiguration(paletteColors: [.cloudDarkColor])
            return UIImage(systemName: "tropicalstorm")!.withConfiguration(config)
            
        case .windy:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor])
            return UIImage(systemName: "wind")!.withConfiguration(config)
            
        case .wintryMix:
            let config = UIImage.SymbolConfiguration(paletteColors: [.windColor, .raindropColor])
            return UIImage(systemName: "cloud.sleet.fill")!.withConfiguration(config)
            
        @unknown default:
            return UIImage(systemName: "exclamationmark.triangle.fill")!
        }
    }
}


extension WeatherCondition {
    var localizedString: String {
        switch self {
        case .blizzard:
            return String(localized: "Blizzard")
        case .blowingDust:
            return String(localized: "Blowing Dust")
        case .blowingSnow:
            return String(localized: "Blowing Snow")
        case .breezy:
            return String(localized: "Breezy")
        case .clear:
            return String(localized: "Clear")
        case .cloudy:
            return String(localized: "Cloudy")
        case .drizzle:
            return String(localized: "Drizzle")
        case .flurries:
            return String(localized: "Flurries")
        case .foggy:
            return String(localized: "Foggy")
        case .freezingDrizzle:
            return String(localized: "Freezing Drizzle")
        case .freezingRain:
            return String(localized: "Freezing Rain")
        case .frigid:
            return String(localized: "Frigid")
        case .hail:
            return String(localized: "Hail")
        case .haze:
            return String(localized: "Haze")
        case .heavyRain:
            return String(localized: "Heavy Rain")
        case .heavySnow:
            return String(localized: "Heavy Snow")
        case .hot:
            return String(localized: "Hot")
        case .hurricane:
            return String(localized: "Hurricane")
        case .isolatedThunderstorms:
            return String(localized: "Isolated Thunderstorms")
        case .mostlyClear:
            return String(localized: "Mostly Clear")
        case .mostlyCloudy:
            return String(localized: "Mostly Cloudy")
        case .partlyCloudy:
            return String(localized: "Partly Cloudy")
        case .rain:
            return String(localized: "Rain")
        case .scatteredThunderstorms:
            return String(localized: "Scattered Thunderstroms")
        case .sleet:
            return String(localized: "Sleet")
        case .smoky:
            return String(localized: "Smoky")
        case .snow:
            return String(localized: "Snow")
        case .strongStorms:
            return String(localized: "Strong Stroms")
        case .sunFlurries:
            return String(localized: "Sun Flurries")
        case .sunShowers:
            return String(localized: "Sun Showers")
        case .thunderstorms:
            return String(localized: "Thunderstorms")
        case .tropicalStorm:
            return String(localized: "Tropical Strom")
        case .windy:
            return String(localized: "Windy")
        case .wintryMix:
            return String(localized: "Wintry Mix")
        @unknown default:
            return String(localized: "Unknown Weather Condition")
        }
    }
}
