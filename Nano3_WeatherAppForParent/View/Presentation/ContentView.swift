//
//  ContentView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 08/07/24.
//

import SwiftUI

struct ContentView: View {
    private var num = 1
    @State private var dailyViewModel: DailyViewModel?
    
    var body: some View {
        VStack {
            Image(systemName: "sun.rain.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(String(localized: "Hello, World")) 1")
            
            if self.dailyViewModel != nil {
                Text(self.dailyViewModel?.dailySummary?.morning ?? "Data not fetched")
            }
        }
        .padding()
        .onAppear {
            Task {
                self.dailyViewModel = await DailyViewModel()
            }
        }
    }
}

#Preview {
    ContentView()
}
