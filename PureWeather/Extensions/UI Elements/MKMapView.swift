//
//  MKMapView.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation
import MapKit




extension MKMapView {
    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 10000 // 10 km radius
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotationAtLocation(_ location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        location.getCityName { cityName in
            if let location = cityName {
                annotation.title = location
            } else {
                annotation.title = ""
            }
        }
        annotation.subtitle = "Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)"
        self.addAnnotation(annotation)
    }
}
