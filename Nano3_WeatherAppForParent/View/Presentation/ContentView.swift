//
//  ContentView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 08/07/24.
//

import SwiftUI

struct ContentView: View {
    private var num = 1
    
    var body: some View {
        VStack {
            Image(systemName: "sun.rain.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(String(localized: "Hello, World")) 1")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
