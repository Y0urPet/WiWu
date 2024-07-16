//
//  ContentView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 08/07/24.
//



import SwiftUI
import CoreLocation
import WeatherKit

struct ContentView: View {
    private var weatherManager = WeatherManager.shared
    @State private var weather = WeatherViewModel()

    var body: some View {
//            VStack {
//                Text("Current Location: \(weatherManager.locationName)")
//                    .padding()
//
//                List(weatherManager.dailyWeather) { day in
//                    VStack(alignment: .leading) {
//                        Text("Date: \(day.date)")
//                        Text("Condition: \(day.condition)")
//                        Text("High: \(day.highTemperature) °C")
//                        Text("Low: \(day.lowTemperature) °C")
//                        Text("Precipitation: \(day.precipitation)")
//                        Text("Chance: \(day.precipitationChance * 100)%")
//                        Text("Amount: \(day.precipitationAmount) mm")
//                        Text("Snowfall: \(day.snowfallAmount) mm")
//                        // Display more details as needed
//                    }
//                    .padding()
//                }
//                .padding()
//
//                List(weatherManager.hourlyWeather) { hour in
//                VStack(alignment: .leading) {
//                    Text("Date: \(hour.date)")
//                    Text("Condition: \(hour.condition)")
//                    Text("Temperature: \(hour.temperature) °C")
//                    Text("Apparent Temperature: \(hour.apparentTemperature) °C")
//                    Text("Dew Point: \(hour.dewPoint) °C")
//                    Text("Humidity: \(hour.humidity * 100)%")
//                    Text("Precipitation: \(hour.precipitation)")
//                    Text("Chance: \(hour.precipitationChance * 100)%")
//                    Text("Amount: \(hour.precipitationAmount) mm")
//                    Text("Pressure: \(hour.pressure) mbar")
//                    Text("Pressure Trend: \(hour.pressureTrend)")
//                    Text("UV Index: \(hour.uvIndex.value) (\(hour.uvIndex.category))")
//                    Text("Visibility: \(hour.visibility) m")
//                    Text("Wind: \(hour.wind.compassDirection) at \(hour.wind.speed) km/h")
//                    if let gust = hour.wind.gust {
//                        Text("Gust: \(gust) km/h")
//                    }
//                }
//                .padding()
//            }
//            Button("Refresh Weather") {
//                weatherManager.locationManager.requestLocation()
//            }
//            .padding()
//            
//            
//        }
        MainView()
//            .preferredColorScheme(.light)
//        WeeklyWeatherView()
//        InfoView()
//        WeatherAnimation()
    }
}


#Preview {
    ContentView()
}
