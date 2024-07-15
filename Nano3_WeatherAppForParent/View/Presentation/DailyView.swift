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
    
    var body: some View {
        Text("DailyView")
    }
}

#Preview {
    DailyView()
}
