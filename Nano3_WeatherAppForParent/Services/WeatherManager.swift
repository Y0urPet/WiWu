//
//  WeatherManager.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 11/07/24.
//

import Foundation
import CoreLocation
import WeatherKit

enum WeatherError: Error {
    case encodingFailed
    case fetchingFailed
    case filteringFailed
}

enum WeatherFilter {
    case daily
    case hourly
    case all
}

class WeatherManager {
    // Has a fetch function that gets the data from weather kit
    // Uses delegate to update the weather data in view model
    
    static let shared = WeatherManager()
    private let locationManager = LocationManager.shared
    private let apiClient = ApiClient.shared
    
    var delegate: WeatherManagerDelegate?
    
    private let weatherService = WeatherService()
    
    init() {
        // Fetch update
//        fetch()
    }
    
    
    // TODO: Handle different locations
    func fetch(numOfDays: Double = 7)  {
        // Fetch location first
        LocationManager.shared.requestLocation()
        
        LocationManager.shared.locationUpdateHandler = { location in
            
            // Make queries for weather (one week)
            let queryDaily = WeatherQuery.daily(startDate: .now, endDate: .now + (3600 * 24 * numOfDays))
            let queryHourly = WeatherQuery.hourly(startDate: .now, endDate: .now + (3600 * 24 * numOfDays))
            
            // Task
            Task {
                do {
                    // Query WeatherKit
                    let forecast = try await self.weatherService.weather(for: location, including: queryDaily)
                    let hourlyForecast = try await self.weatherService.weather(for: location, including: queryHourly)
                    
                    DispatchQueue.main.async {
                        let hourlyWeather = self.mapForecastToHourlyWeather(hourlyForecast)
                        let dailyWeather = self.mapForecastToDayWeather(forecast,hourlyWeather)
                        // Notify WeatherViewModel to save the data
                        self.delegate?.getWeather(daily: dailyWeather, hourly: hourlyWeather)
                    }
                    
                } catch {
                    print("Failed to fetch weather: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func encodeWeatherData(dailyWeather: DayWeather, hourlyWeather: [HourlyWeather]) -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let dailyData = try encoder.encode(dailyWeather)
            let hourlyData = try encoder.encode(hourlyWeather)
            
            guard let dailyString = String(data: dailyData, encoding: .utf8),
                  let hourlyString = String(data: hourlyData, encoding: .utf8) else {
                throw WeatherError.encodingFailed
            }
            
            let jsonString = """
            {
                "dailyWeather": \(dailyString),
                "hourlyWeather": \(hourlyString)
            }
            """
            
            return jsonString
        } catch {
            print("Failed to encode data: \(error.localizedDescription)")
            return ""
        }
    }
    
    func filterPerDay(filter: WeatherFilter = .all, dailyWeather: [DayWeather], hourlyWeather: [HourlyWeather], date: Date) -> (DayWeather?, [HourlyWeather]) {

        // Get the calendar
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        // Set the start of the provided day
        let startOfDay = calendar.startOfDay(for: date)
        // Set the end of the provided day (start of the next day minus one second)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1)
        
        debugPrint("start: \(startOfDay) | end: \(String(describing: endOfDay))")

        
        // Filter the HourlyWeather array
        let todaysHourlyWeather: [HourlyWeather] = hourlyWeather.filter { weather in
            guard let endOfDay = endOfDay else { return false }
            return weather.date >= startOfDay && weather.date <= endOfDay
        }

        // Filter the DayWeather array
        let todaysDayWeather: DayWeather? = dailyWeather.first { weather in
            return calendar.isDate(weather.date, inSameDayAs: date)
        }
        
        return (todaysDayWeather, todaysHourlyWeather)
    }
   
}

