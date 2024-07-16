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
            return UIImage(systemName: "wind.snow")!
        case .blowingDust:
            return UIImage(systemName: "")! // UNKNOWN
        case .blowingSnow:
            return UIImage(systemName: "wind.snow")!
        case .breezy:
            return UIImage(systemName: "wind")!
        case .clear:
            return UIImage(systemName: "")!
        case .cloudy:
            return UIImage(systemName: "cloud.fill")!
        case .drizzle:
            return UIImage(systemName: "cloud.drizzle.fill")!
        case .flurries:
            return UIImage(systemName: "cloud.snow.fill")!
        case .foggy:
            return UIImage(systemName: "cloud.fog.fill")!
        case .freezingDrizzle:
            return UIImage(systemName: "cloud.sleet.fill")!
        case .freezingRain:
            return UIImage(systemName: "")!
        case .frigid:
            return UIImage(systemName: "")!
        case .hail:
            return UIImage(systemName: "cloud.hail.fill")!
        case .haze:
            return UIImage(systemName: "")!
        case .heavyRain:
            return UIImage(systemName: "cloud.heavyrain.fill")!
        case .heavySnow:
            return UIImage(systemName: "")!
        case .hot:
            return UIImage(systemName: "")!
        case .hurricane:
            return UIImage(systemName: "hurricane")!
        case .isolatedThunderstorms:
            return UIImage(systemName: "")!
        case .mostlyClear:
            return UIImage(systemName: "")!
        case .mostlyCloudy:
            return UIImage(systemName: "")!
        case .partlyCloudy:
            return UIImage(systemName: "")!
        case .rain:
            return UIImage(systemName: "cloud.rain.fill")!
        case .scatteredThunderstorms:
            return UIImage(systemName: "")!
        case .sleet:
            return UIImage(systemName: "cloud.sleet.fill")!
        case .smoky:
            return UIImage(systemName: "smoke.fill")!
        case .snow:
            return UIImage(systemName: "cloud.snow")!
        case .strongStorms:
            return UIImage(systemName: "")!
        case .sunFlurries:
            return UIImage(systemName: "sun.snow")!
        case .sunShowers:
            return UIImage(systemName: "sun.rain.fill")!
        case .thunderstorms:
            return UIImage(systemName: "")!
        case .tropicalStorm:
            return UIImage(systemName: "tropicalstorm")!
        case .windy:
            return UIImage(systemName: "wind")!
        case .wintryMix:
            return UIImage(systemName: "")!
        @unknown default:
            return UIImage(systemName: "")!
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
