//
//  WeatherViewModel.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 12/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

@Observable
class WeatherViewModel : WeatherManagerDelegate {
    
    // TODO: Implement caching for current location
    
    var weatherManager = WeatherManager.shared
    let apiClient = ApiClient.shared
    
    var locationName: String = "Current Location"
    var location: CLLocation?
    
    var dailyWeather: [DayWeather] = []
    var hourlyWeather: [HourlyWeather] = []
    
    var dailySummaries: [DailySummary]?
    
    init() {
        weatherManager.delegate = self
    }
    
    func getWeather(daily: [DayWeather], hourly: [HourlyWeather]) {
        self.dailyWeather = daily
        self.hourlyWeather = hourly
        
        processWeatherData()
    }

    
    private func processWeatherData() {
        Task {
            for day in dailyWeather {
                let (todaysDayWeather, todaysHourlyWeather) = weatherManager.filterPerDay(dailyWeather: dailyWeather, hourlyWeather: hourlyWeather, date: day.date)
                
                if let todaysDayWeather = todaysDayWeather {
                    let encodedWeatherData = weatherManager.encodeWeatherData(dailyWeather: todaysDayWeather, hourlyWeather: todaysHourlyWeather)
                    await fetchDailySummary(encodedWeatherData: encodedWeatherData, for: day.date)
                }
            }
        }
    }
    
    private func fetchDailySummary(encodedWeatherData: String, for date: Date) async {
        do {
            let dailySummary: DailySummary = try await apiClient.fetchDailySummary(dataStr: encodedWeatherData)
            dailySummaries = []
            dailySummaries?.append(dailySummary)
            
            print("Daily Summary for \(date): \(dailySummary)")
        } catch {
            print("Failed to fetch daily summary for \(date): \(error.localizedDescription)")
        }
    }
}
