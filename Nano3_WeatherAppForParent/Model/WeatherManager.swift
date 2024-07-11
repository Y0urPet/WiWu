//
//  WeatherManager.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 11/07/24.
//

import Foundation
import CoreLocation
import WeatherKit

class WeatherManager: NSObject, ObservableObject {
    let locationManager = LocationManager()
    private let weatherService = WeatherService()
    
    @Published var currentWeather: CurrentWeather?
    @Published var locationName: String = "Current Location"
    
    override init() {
        super.init()
        locationManager.locationUpdateHandler = { [weak self] location in
            self?.fetchWeather(for: location)
        }
    }
    
    func fetchWeather(for location: CLLocation) {
        let query = WeatherQuery.daily(startDate: .now, endDate: .now + (3600*24*7))
        Task {
            do {
                let weather = try await weatherService.weather(for: location, including: query)
                DispatchQueue.main.async {
//                    self.currentWeather = weather.currentWeather
                    weather.forEach{day in
                    print(day)}
                    self.locationName = "\(location.coordinate.latitude), \(location.coordinate.longitude)" // Optionally, use reverse geocoding to get the place name
                }
            } catch {
                print("Failed to fetch weather: \(error.localizedDescription)")
            }
        }
    }
}
