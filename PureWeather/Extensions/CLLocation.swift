//
//  CLLocation.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation
import MapKit



extension CLLocation {
    func makeString() -> String {
        let latitude = String(format: "%f", self.coordinate.latitude)
        let longitude = String(format: "%f", self.coordinate.longitude)
        let result = "\(latitude)_\(longitude)"
        return result
    }
    
    func getCityName(completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(self) { placemarks, error in
            guard error == nil else {
                print("Reverse geocoding failed: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first, let city = placemark.locality {
                completion(city)
            } else {
                completion(nil)
            }
        }
    }
    
    convenience init?(from coordinateString: String) {
        let components = coordinateString.split(separator: "_")
        
        guard components.count == 2,
              let latitude = Double(components[0]),
              let longitude = Double(components[1]) else {
            return nil
        }
        
        self.init(latitude: latitude, longitude: longitude)
    }
}
