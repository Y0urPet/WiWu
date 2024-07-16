//
//  PrepItems.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 15/07/24.
//

import Foundation

import Foundation

enum PrepCategory: String, Codable {
    case clothes
    case items
}

struct PrepItem: Identifiable, Codable,Equatable {
    var id = UUID()
    var title: String
    var category: PrepCategory
    var icon: String
    var priority: UInt16 = 1
    var image: String = ""
}

struct PrepItemPresets {
    static let clothes: [PrepItem] = [
        PrepItem(title: String(localized: "Short sleeved cotton or linen shirt"), category: .clothes, icon: "tshirt", priority: 1),
        PrepItem(title: String(localized: "Thigh to knee length pants"), category: .clothes, icon: "shorts", priority: 1),
        PrepItem(title: String(localized: "Thick soled shoes or sandals"), category: .clothes, icon: "shoe.fill", priority: 2),
        PrepItem(title: String(localized: "Thin and lightweight jacket"), category: .clothes, icon: "jacket", priority: 2)
    ]

    static let items: [PrepItem] = [
        PrepItem(title: String(localized: "Bring sunscreen"), category: .items, icon: "sun.max.fill", priority: 3),
        PrepItem(title: String(localized: "Bring a hat"), category: .items, icon: "cap.fill", priority: 1),
        PrepItem(title: String(localized: "Bring sunglasses"), category: .items, icon: "sunglasses", priority: 1),
        PrepItem(title: String(localized: "Bring a water bottle"), category: .items, icon: "drop.fill", priority: 1),
        PrepItem(title: String(localized: "Bring an umbrella"), category: .items, icon: "umbrella.fill", priority: 1),
        PrepItem(title: String(localized: "Bring a raincoat"), category: .items, icon: "cloud.rain.fill", priority: 1),
        PrepItem(title: String(localized: "Bring gloves"), category: .items, icon: "glove.fill", priority: 1),
        PrepItem(title: String(localized: "Bring a scarf"), category: .items, icon: "scarf.fill", priority: 2),
        PrepItem(title: String(localized: "Bring a portable fan"), category: .items, icon: "fanblades.fill", priority: 3),
        PrepItem(title: String(localized: "Bring toddler safe sunscreen"), category: .items, icon: "baby.bottle.fill", priority: 1)
    ]
}

func generatePrepItems(dayWeather: DayWeather, hourlyWeather: [HourlyWeather]) -> [PrepItem] {
    var prepItems = [PrepItem]()
    
    for weather in hourlyWeather {
        if weather.uvIndex.value > 5 {
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring sunscreen") }!)
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a hat") }!)
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring sunglasses") }!)
        }
        
        if weather.temperature > 25 {
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a water bottle") }!)
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a portable fan") }!)
        }
        
        if weather.precipitationChance > 0.5 {
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring an umbrella") }!)
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a raincoat") }!)
        }
        
        if weather.temperature < 5 {
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring gloves") }!)
            prepItems.append(PrepItemPresets.items.first { $0.title == String(localized: "Bring a scarf") }!)
        }
        
        prepItems.append(contentsOf: PrepItemPresets.clothes)
    }
    
    return prepItems
}
