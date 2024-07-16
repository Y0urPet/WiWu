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
    
    var locationName: String?
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
//    private func processWeatherData() {
//        Task {
//            dailySummaries = []
//            for day in dailyWeather {
//                
//                // Fetch todays weather in a list of weaather data
//                let (todaysDayWeather, todaysHourlyWeather) = weatherManager.filterPerDay(dailyWeather: dailyWeather, hourlyWeather: hourlyWeather, date: day.date)
//                
//                if let todaysDayWeather = todaysDayWeather {
//                    let encodedWeatherData = weatherManager.encodeWeatherData(dailyWeather: todaysDayWeather, hourlyWeather: todaysHourlyWeather)
//                    if var dailySummary = await fetchDailySummary(encodedWeatherData: encodedWeatherData, for: day.date) {
//                        
//                        // Generate prep items
//                        dailySummary.prepItems =  generatePrepItems(dayWeather: todaysDayWeather, hourlyWeather: todaysHourlyWeather)
//                        
//                        // Append to dailySummaries array
//                        dailySummaries?.append(dailySummary)
//                    }
//                }
//            }
//        }
//    }
   
    private func fetchDailySummary(encodedWeatherData: String, for date: Date) async {
               do {
                   let dailySummary: DailySummary = try await apiClient.fetchDailySummary(dataStr: encodedWeatherData)
                   
                   if let index = dailyWeather.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                       dailyWeather[index].dailySummary = dailySummary
                       print("Daily Summary for \(date): \(dailySummary)")
                   }
               } catch {
                   print("Failed to fetch daily summary for \(date): \(error.localizedDescription)")
               }
           }
   
//    private func fetchDailySummary(encodedWeatherData: String, for date: Date) async -> DailySummary? {
//        do {
//            let dailySummary: DailySummary = try await apiClient.fetchDailySummary(dataStr: encodedWeatherData)
//            print("Daily Summary for \(date): \(dailySummary)")
//            return dailySummary
//        } catch {
//            print("Failed to fetch daily summary for \(date): \(error.localizedDescription)")
//            return nil
//        }
//    }
    
    func generatePrepItems(dayWeather: DayWeather, hourlyWeather: [HourlyWeather]) -> [PrepItem] {
        var prepItems = [PrepItem]()
        
        for weather in hourlyWeather {
            if weather.uvIndex.value > 5 {
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring sunscreen") }!)
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a hat") }!)
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring sunglasses") }!)
            }
            
            if weather.temperature > 25 {
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a water bottle") }!)
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a portable fan") }!)
            }
            
            if weather.precipitationChance > 0.5 {
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring an umbrella") }!)
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a raincoat") }!)
            }
            
            if weather.temperature < 5 {
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring gloves") }!)
                prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a scarf") }!)
            }
            
            prepItems.append(contentsOf: PrepItemPresets.clothes)
        }
        
        return prepItems
    }
}
