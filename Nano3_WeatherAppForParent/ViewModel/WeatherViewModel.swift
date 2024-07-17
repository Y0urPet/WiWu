//
//  WeatherViewModel.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 12/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

enum WeatherDataState {
    case notReady
    case fetchingWeather
    case fetchedWeather
    case fetchingGPT
    case ready
}

@Observable
class WeatherViewModel : WeatherManagerDelegate {

    
    // TODO: Implement caching for current location
    
    var weatherManager = WeatherManager.shared
    var locationManager = LocationManager.shared
    let apiClient = ApiClient.shared
    
    var locationName: String = ""
    var location: CLLocation?
    
    var dailyWeather: [DayWeather] = []
    var hourlyWeather: [HourlyWeather] = []
    
    var dailySummaries: [DailySummary]?
    
    var dataState = WeatherDataState.notReady
    
    init() {
        weatherManager.delegate = self
    }
    
    func getWeather(daily: [DayWeather], hourly: [HourlyWeather]) {
        self.dailyWeather = daily
        self.hourlyWeather = hourly
        
        if let latestLocation = LocationManager.shared.latestLocation {
            debugPrint("Latest location: \(latestLocation)")
            
            // Get the location name
            LocationManager.shared.reverseGeocodeLocation(location: latestLocation) { locationName in
                if let locationName = locationName {
                    self.locationName = locationName
                } else {
                    print("Failed to retrieve the location name.")
                }
            }
        } else {
            print("Failed to retrieve the latest location.")
        }
        
        processWeatherData()
    }

    private func processWeatherData() {
        dataState = .notReady
        
        // Save locationName in viewModel
        Task {
            // Print hourlyWeather condition descriptions
//            for hourlyWeather in hourlyWeather {
//                print(hourlyWeather.condition.description)
//            }
//            
            for day in dailyWeather {
                let (todaysDayWeather, todaysHourlyWeather) = weatherManager.filterPerDay(dailyWeather: dailyWeather, hourlyWeather: hourlyWeather, date: day.date)
                
                if let todaysDayWeather = todaysDayWeather {
                    let encodedWeatherData = weatherManager.encodeWeatherData(dailyWeather: todaysDayWeather, hourlyWeather: todaysHourlyWeather)
                    await fetchDailySummary(encodedWeatherData: encodedWeatherData, for: day.date)
                }
            }
            
            dataState = .ready
        }
    }

   
    private func fetchDailySummary(encodedWeatherData: String, for date: Date) async {
               do {
                   var dailySummary: DailySummary = try await apiClient.fetchDailySummary(dataStr: encodedWeatherData)
                   
                   if let index = dailyWeather.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                       
                       // Generate prep items
                       dailySummary.prepItems = generatePrepItems(for: dailyWeather[index].hourlyWeather)

                       
                       dailyWeather[index].dailySummary = dailySummary
                       
                       print(dailyWeather[index].dailySummary.prepItems)
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
    
}
