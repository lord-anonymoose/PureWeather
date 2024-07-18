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
import MapKit




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
    
    var config = Realm.Configuration(encryptionKey: EncryptionService.shared().getOrGenerateEncryptionKey())

    private init() {}
    
    static func shared() -> StorageService {
        return StorageService()
    }
    
    func postLocation(location: CLLocation) {
        let storedLocation = location.makeStored()
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(storedLocation)
            }
        } catch {
            print("Failed to write a quote: \(error)")
            return
        }
    }
    
    func deleteLocation(location: CLLocation) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                let storedLocation = location.makeStored()
                realm.delete(storedLocation)
            }
        } catch {
            print("Failed to delete a location: \(error)")
            return
        }
    }
    
    func fetchLocations() -> [CLLocation] {
        do {
            let realm = try Realm(configuration: config)
            let storedLocations = realm.objects(StoredLocation.self)
            var locations = [CLLocation]()
            for storedLocation in storedLocations {
                let location = CLLocation(from: storedLocation.coordinates)
                if let newLocation = location {
                    locations.append(newLocation)
                }
            }
            return Array(locations)
        } catch {
            print("Failed to fetch locations from Realm: \(error)")
            return []
        }
    }
}

