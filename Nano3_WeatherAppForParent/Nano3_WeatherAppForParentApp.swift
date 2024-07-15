//
//  Nano3_WeatherAppForParentApp.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 08/07/24.
//

import SwiftUI
import SwiftData

@main
struct Nano3_WeatherAppForParentApp: App {
//    let container : ModelContainer = {
//        let schema = Schema([Location.self])
//        
//        // TODO: Change isStoredInMemoryOnly -> false
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try! ModelContainer(for: schema, configurations: config)
//        
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(container)
    }
}
