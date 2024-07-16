//
//  LocationManager.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 11/07/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locationUpdateHandler: ((CLLocation) -> Void)?
    
    var latestLocation: CLLocation?
    var locationName: String = ""
    
    static let shared = LocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        latestLocation = location // Store the latest location
        locationUpdateHandler?(location)
        
    }
    
    func reverseGeocodeLocation(location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                let locationName = placemark.name ?? ""
                print("Location Name: \(locationName)")
                completion(locationName)
            } else {
                print("No location name found.")
                completion(nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
