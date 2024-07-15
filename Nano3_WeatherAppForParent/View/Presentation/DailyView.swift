//
//  DailyView.swift
//  Nano3_WeatherAppForParent
//
//



import SwiftUI
import CoreLocation
import WeatherKit

struct DailyView: View {
    @State private var weather = WeatherViewModel()
    @State private var isExpanded = false
    var body: some View {
        Text("DailyView")
        VStack {
//                        List(weather.dailyWeather) { day in
//                            VStack(alignment: .leading) {
//                                Text("Date: \(day.date)")
//                                Text("Condition: \(day.condition)")
//                                Text("High: \(day.highTemperature) °C")
//                                Text("Low: \(day.lowTemperature) °C")
//                                Text("Precipitation: \(day.precipitation)")
//                                Text("Chance: \(day.precipitationChance * 100)%")
//                                Text("Amount: \(day.precipitationAmount) mm")
//                                Text("Snowfall: \(day.snowfallAmount) mm")
//                                // Display more details as needed
//                            }
//                            .padding()
//                        }
//                        .padding()
        
//                        List(weather.hourlyWeather) { hour in
//                        VStack(alignment: .leading) {
//                            Text("Date: \(hour.date)")
//                            Text("Condition: \(hour.condition)")
//                            Text("Temperature: \(hour.temperature) °C")
//                            Text("Apparent Temperature: \(hour.apparentTemperature) °C")
//                            Text("Dew Point: \(hour.dewPoint) °C")
//                            Text("Humidity: \(hour.humidity * 100)%")
//                            Text("Precipitation: \(hour.precipitation)")
//                            Text("Chance: \(hour.precipitationChance * 100)%")
//                            Text("Amount: \(hour.precipitationAmount) mm")
//                            Text("Pressure: \(hour.pressure) mbar")
//                            Text("Pressure Trend: \(hour.pressureTrend)")
//                            Text("UV Index: \(hour.uvIndex.value) (\(hour.uvIndex.category))")
//                            Text("Visibility: \(hour.visibility) m")
//                            Text("Wind: \(hour.wind.compassDirection) at \(hour.wind.speed) km/h")
//                            if let gust = hour.wind.gust {
//                                Text("Gust: \(gust) km/h")
//                            }
//                        }
//                        .padding()
//                    }
            HStack {
                Text("Weather Forecast")
                    .font(.headline)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            // Content of the card
            if isExpanded {
                VStack {
                    ForEach($weather.hourlyWeather) { data in
                        HStack {
                            Text("Date: \(data.date.wrappedValue.getHour())")
                                .padding()
                                .onAppear{
                                    print(data.date.wrappedValue.getHour())
                                }
                            Spacer()
                            
                        }
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                        .padding([.leading, .trailing, .top], 5)
                    }
                }
                .transition(.slide)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
                    Button("Refresh Weather") {
                        weather.weatherManager.fetch()
                    }
                    .padding()
                }
    }


#Preview {
    DailyView()
}
