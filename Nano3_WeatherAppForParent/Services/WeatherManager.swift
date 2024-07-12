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

class WeatherManager: NSObject, ObservableObject {
    let locationManager = LocationManager()
    private let weatherService = WeatherService()
    private let apiClient = ApiClient.shared
    
    @Published var currentWeather: CurrentWeather?
    @Published var locationName: String = "Current Location"
    @Published var dailyWeather: [DayWeather] = []
    @Published var hourlyWeather: [HourlyWeather] = []
    
    override init() {
        super.init()
        locationManager.locationUpdateHandler = { [weak self] location in
            do {
                try self?.fetchWeather(for: location)
            }
            catch {
                
            }
        }
    }
    
    func encodeHourlyWeather(hourlyWeather: [HourlyWeather]) throws -> String {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(hourlyWeather)
            let jsonString = String(data: jsonData, encoding: .utf8)
            if let jsonString = jsonString {
                return jsonString
            }
            print("Failed to encode")
        } catch {
            print("Failed to encode data: \(error.localizedDescription)")
        }
        
        return ""
    }
    
    func filterPerDay(date: Date) throws -> (DayWeather, [HourlyWeather]) {
        // Get the calendar
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        // Set the start of the provided day
        let startOfDay = calendar.startOfDay(for: date)
        // Set the end of the provided day (start of the next day minus one second)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1)
        
        debugPrint("start: \(startOfDay) | end: \(String(describing: endOfDay))")

        // Filter the HourlyWeather array
        let todaysHourlyWeather: [HourlyWeather] = self.hourlyWeather.filter { weather in
            guard let endOfDay = endOfDay else { return false }
            return weather.date >= startOfDay && weather.date <= endOfDay
        }

        // Filter the DayWeather array
        let todaysDayWeathers: [DayWeather] = self.dailyWeather.filter { weather in
            return calendar.isDate(weather.date, inSameDayAs: date)
        }
        
        let todaysDayWeather = todaysDayWeathers.first
        
        return (todaysDayWeather, todaysHourlyWeather)
        
        // Print the filtered array
//        debugPrint("todaysHourlyWeather ->", todaysHourlyWeather.count, ": ", todaysHourlyWeather)
//        debugPrint("todaysDayWeather", todaysDayWeather)
//        
//        let encoded = self.encodeHourlyWeather(hourlyWeather: todaysHourlyWeather)
//        debugPrint(encoded)
//        debugPrint("[WeatherKit]")
//        
//        Task {
//            let sum = try await self.apiClient.fetchDailySummary(dataStr: encoded)
//            debugPrint("[serializing]")
//            let json: Any = try JSONSerialization.jsonObject(with: sum, options: [])
//            debugPrint("[fetch]", json)
//        }
    }
    
    func fetchWeather(for location: CLLocation)  {
            let queryDaily = WeatherQuery.daily(startDate: .now, endDate: .now + (3600 * 24 * 7))
        let queryHourly = WeatherQuery.hourly(startDate: .now, endDate: .now + (3600 * 24 * 7))
            Task {
                do {
                    let forecast = try await weatherService.weather(for: location, including: queryDaily)
                    let hourlyForecast = try await weatherService.weather(for: location, including: queryHourly)
                    DispatchQueue.main.async {
//                        for day in forecast{
//                            print(day)
//                        }self.dailyWeather = self.mapForecastToDayWeather(dailyForecast)
                        self.dailyWeather = self.mapForecastToDayWeather(forecast)
                        self.hourlyWeather = self.mapForecastToHourlyWeather(hourlyForecast)
//                        print(self.hourlyWeather)
                        self.locationName = "\(location.coordinate.latitude), \(location.coordinate.longitude)"

                        self.filterPerDay(date: .now + (3600 * 24 * 3))
                    }

                } catch {
                    print("Failed to fetch weather: \(error.localizedDescription)")
                }
            }
        }

    func temperatureToDouble(_ temperature: Measurement<UnitTemperature>) -> Double {
        return temperature.value
    }

    func lengthToDouble(_ length: Measurement<UnitLength>) -> Double {
        return length.value
    }

    func precipitationToString(_ precipitation: Precipitation) -> String {
        switch precipitation {
        case .none:
            return "None"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
            
        // Add other cases as necessary
        default:
            return "Unknown"
        }
    }

    func weatherConditionToString(_ condition: WeatherCondition) -> String {
        switch condition {
        case .clear:
            return "Clear"
        case .cloudy:
            return "Cloudy"
        case .partlyCloudy:
            return "Partly Cloudy"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
        // Add other cases as necessary
        default:
            return "Unknown"
        }
    }
    
    func angleToDouble(_ angle: Measurement<UnitAngle>) -> Double {
        return angle.value
    }
    func pressureTrendToString(_ trend: WeatherKit.PressureTrend) -> String {
        switch trend {
        case .falling:
            return "Falling"
        case .rising:
            return "Rising"
        case .steady:
            return "Steady"
        default:
            return "Unknown"
        }
    }
    private func mapForecastToDayWeather(_ forecast: Forecast<WeatherKit.DayWeather>) -> [DayWeather] {
        return forecast.map { weatherKitDayWeather in
            DayWeather(
                date: weatherKitDayWeather.date,
                condition: weatherConditionToString(weatherKitDayWeather.condition),
                symbolName: weatherKitDayWeather.symbolName,
                highTemperature: temperatureToDouble(weatherKitDayWeather.highTemperature),
                lowTemperature: temperatureToDouble(weatherKitDayWeather.lowTemperature),
                precipitation: precipitationToString(weatherKitDayWeather.precipitation),
                precipitationChance: weatherKitDayWeather.precipitationChance,
                precipitationAmount: lengthToDouble(weatherKitDayWeather.precipitationAmount),
                snowfallAmount: lengthToDouble(weatherKitDayWeather.snowfallAmount),
                sun: SunEvents(
                    astronomicalDawn: weatherKitDayWeather.sun.astronomicalDawn,
                    nauticalDawn: weatherKitDayWeather.sun.nauticalDawn,
                    civilDawn: weatherKitDayWeather.sun.civilDawn,
                    sunrise: weatherKitDayWeather.sun.sunrise,
                    solarNoon: weatherKitDayWeather.sun.solarNoon,
                    sunset: weatherKitDayWeather.sun.sunset,
                    civilDusk: weatherKitDayWeather.sun.civilDusk,
                    nauticalDusk: weatherKitDayWeather.sun.nauticalDusk,
                    astronomicalDusk: weatherKitDayWeather.sun.astronomicalDusk,
                    solarMidnight: weatherKitDayWeather.sun.solarMidnight
                ),
                moon: MoonEvents(
                    phase: weatherKitDayWeather.moon.phase.rawValue,
                    moonrise: weatherKitDayWeather.moon.moonrise,
                    moonset: weatherKitDayWeather.moon.moonset
                ),
                uvIndex: UVIndex(
                    value: weatherKitDayWeather.uvIndex.value,
                    category: weatherKitDayWeather.uvIndex.category.rawValue
                ),
                wind: Wind(
                    compassDirection: weatherKitDayWeather.wind.compassDirection.rawValue,
                    direction: angleToDouble(weatherKitDayWeather.wind.direction),
                    speed: weatherKitDayWeather.wind.speed.value,
                    gust: weatherKitDayWeather.wind.gust?.value
                )
            )
        }
    }
    private func mapForecastToHourlyWeather(_ forecast: Forecast<WeatherKit.HourWeather>) -> [HourlyWeather] {
           return forecast.map { weatherKitHourWeather in
               HourlyWeather(
                   date: weatherKitHourWeather.date,
                   cloudCover: weatherKitHourWeather.cloudCover,
//                   cloudCoverLow: 0,
//                   cloudCoverMid: 0,
//                   cloudCoverHigh: 0,
                   condition: weatherConditionToString(weatherKitHourWeather.condition),
                   symbolName: weatherKitHourWeather.symbolName,
                   dewPoint: temperatureToDouble(weatherKitHourWeather.dewPoint),
                   humidity: weatherKitHourWeather.humidity,
                   isDaylight: weatherKitHourWeather.isDaylight,
                   precipitation: precipitationToString(weatherKitHourWeather.precipitation),
                   precipitationChance: weatherKitHourWeather.precipitationChance,
                   precipitationAmount: lengthToDouble(weatherKitHourWeather.precipitationAmount),
//                   snowfallAmount: 0.0,
                   pressure: weatherKitHourWeather.pressure.value,
                   pressureTrend: pressureTrendToString(weatherKitHourWeather.pressureTrend),
                   temperature: temperatureToDouble(weatherKitHourWeather.temperature),
                   apparentTemperature: temperatureToDouble(weatherKitHourWeather.apparentTemperature),
                   uvIndex: HourlyWeather.UVIndex(
                       value: weatherKitHourWeather.uvIndex.value,
                       category: weatherKitHourWeather.uvIndex.category.rawValue
                   ),
                   visibility: weatherKitHourWeather.visibility.value,
                   wind: HourlyWeather.Wind(
                       compassDirection: weatherKitHourWeather.wind.compassDirection.rawValue,
                       direction: angleToDouble(weatherKitHourWeather.wind.direction),
                       speed: weatherKitHourWeather.wind.speed.value,
                       gust: weatherKitHourWeather.wind.gust?.value
                   )
               )
           }
       }
}
