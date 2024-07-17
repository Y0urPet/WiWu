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
        MainView()
    }
}


#Preview {
    ContentView()
}
