//
//  WeatherManager+Parsing.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 12/07/24.
//

import Foundation
import WeatherKit

extension WeatherManager {
    
    func temperatureToDouble(_ temperature: Measurement<UnitTemperature>) -> Double {
        return temperature.value
    }

    func lengthToDouble(_ length: Measurement<UnitLength>) -> Double {
        return length.value
    }

    func precipitationToString(_ precipitation: Precipitation) -> String {
        switch precipitation {
        case .none:
            return String(localized: "None")
        case .rain:
            return String(localized: "Rain")
        case .snow:
            return String(localized: "Snow")
            
        // Add other cases as necessary
        default:
            return String(localized: "Clear")
        }
    }

    func weatherConditionToString(_ condition: WeatherCondition) -> String {
        switch condition {
        case .clear:
            return String(localized: "Clear")
        case .cloudy:
            return String(localized: "Cloudy")
        case .partlyCloudy:
            return String(localized: "Partly Cloudy")
        case .rain:
            return String(localized: "Rain")
        case .snow:
            return String(localized: "Snow")
        // Add other cases as necessary
        default:
            return String(localized: "Clear")
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
    
    func mapForecastToDayWeather(_ forecast: Forecast<WeatherKit.DayWeather>,_ hourlyWeather: [HourlyWeather]) -> [DayWeather] {
        var calendar = Calendar.current
                  calendar.timeZone = TimeZone.current
                  
                  // Function to filter hourly weather for a given date
                  func filterHourlyWeather(for date: Date) -> [HourlyWeather] {
                      let startOfDay = calendar.startOfDay(for: date)
                      let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1)
                      
                      return hourlyWeather.filter { weather in
                          guard let endOfDay = endOfDay else { return false }
                          return weather.date >= startOfDay && weather.date <= endOfDay
                      }
                  }
        
        return forecast.map { weatherKitDayWeather in
            let todaysHourlyWeather = filterHourlyWeather(for: weatherKitDayWeather.date)
            return DayWeather(
                date: weatherKitDayWeather.date,
                condition: weatherConditionToString(weatherKitDayWeather.condition),
                symbolName: "\(weatherKitDayWeather.symbolName).fill",
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
                ),
                hourlyWeather: todaysHourlyWeather,
                dailySummary: DailySummary()
            )
        }
    }
    func mapForecastToHourlyWeather(_ forecast: Forecast<WeatherKit.HourWeather>) -> [HourlyWeather] {
           return forecast.map { weatherKitHourWeather in
               HourlyWeather(
                   date: weatherKitHourWeather.date,
                   cloudCover: weatherKitHourWeather.cloudCover,
//                   cloudCoverLow: 0,
//                   cloudCoverMid: 0,
//                   cloudCoverHigh: 0,
                   condition: weatherKitHourWeather.condition.description,
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
