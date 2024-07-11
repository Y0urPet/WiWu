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
    @StateObject private var weatherManager = WeatherManager()

    var body: some View {
        VStack {
            if let currentWeather = weatherManager.currentWeather {
                Text("Weather at \(weatherManager.locationName)")
                    .font(.largeTitle)
                    .padding()
                
                Text("\(Int(currentWeather.temperature.value))°C")
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            } else {
                Text("Loading...")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .onAppear {
            weatherManager.locationManager.requestLocation()
        }
    }
}


#Preview {
    ContentView()
}
