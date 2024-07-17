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

struct PrepItem: Identifiable, Codable, Equatable, Hashable {
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
        PrepItem(title: String(localized: "Thin and lightweight jacket"), category: .clothes, icon: "jacket", priority: 2),
        PrepItem(title: String(localized: "Warm winter coat"), category: .clothes, icon: "coat", priority: 1),
        PrepItem(title: String(localized: "Thermal underwear"), category: .clothes, icon: "thermals", priority: 1),
        PrepItem(title: String(localized: "Wool socks"), category: .clothes, icon: "socks", priority: 1),
        PrepItem(title: String(localized: "Waterproof boots"), category: .clothes, icon: "boot", priority: 1),
        PrepItem(title: String(localized: "Rainproof hat"), category: .clothes, icon: "hat", priority: 2)
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
        PrepItem(title: String(localized: "Bring toddler safe sunscreen"), category: .items, icon: "baby.bottle.fill", priority: 1),
        PrepItem(title: String(localized: "Bring a flashlight"), category: .items, icon: "flashlight.on.fill", priority: 2),
        PrepItem(title: String(localized: "Bring a first aid kit"), category: .items, icon: "cross.fill", priority: 1),
        PrepItem(title: String(localized: "Bring insect repellent"), category: .items, icon: "ant.fill", priority: 2),
        PrepItem(title: String(localized: "Bring a reusable shopping bag"), category: .items, icon: "bag.fill", priority: 3),
        PrepItem(title: String(localized: "Bring snacks"), category: .items, icon: "cart.fill", priority: 1),
        PrepItem(title: String(localized: "Bring MORE snacks"), category: .items, icon: "cart.fill", priority: 1),
        PrepItem(title: String(localized: "Bring a blanket"), category: .items, icon: "bed.double.fill", priority: 2)
        
    ]
}

func getDummyPrepItems() -> [PrepItem] {
    var prepItems = [PrepItem]()
    
    prepItems.append(contentsOf: [
        PrepItemPresets.items.first { $0.title == String(localized: "Bring an umbrella") }!,
        PrepItemPresets.items.first { $0.title == String(localized: "Bring a raincoat") }!,
        PrepItemPresets.clothes.first { $0.title == String(localized: "Rainproof hat") }!
    ])
    
    prepItems.append(contentsOf: [
        PrepItemPresets.items.first { $0.title == String(localized: "Bring snacks") }!,
        PrepItemPresets.items.first { $0.title == String(localized: "Bring MORE snacks") }!,
    ])
    
    
    return prepItems
}

func generatePrepItems(for weatherData: [HourlyWeather]) -> [PrepItem] {
    var prepItems = [PrepItem]()

    // Example thresholds and mappings
    let highUVIndexThreshold = 6
    let rainThreshold = 0.1
    let strongWindThreshold = 15.0
    let coldTemperatureThreshold = 10.0 // degrees Celsius
    let hotTemperatureThreshold = 30.0 // degrees Celsius

    var isRainy = false
    var isSunny = false
    var isWindy = false
    var highUVIndex = false
    var isCold = false
    var isHot = false

    for hourly in weatherData {
        if hourly.precipitationAmount > rainThreshold {
            isRainy = true
        }
        if hourly.symbolName == "sun.max.fill" {
            isSunny = true
        }
        if hourly.wind.speed > strongWindThreshold {
            isWindy = true
        }
        if hourly.uvIndex.value >= highUVIndexThreshold {
            highUVIndex = true
        }
        if hourly.temperature <= coldTemperatureThreshold {
            isCold = true
        }
        if hourly.temperature >= hotTemperatureThreshold {
            isHot = true
        }
    }

    if isRainy {
        prepItems.append(contentsOf: [
            PrepItemPresets.items.first { $0.title == String(localized: "Bring an umbrella") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring a raincoat") }!,
            PrepItemPresets.clothes.first { $0.title == String(localized: "Rainproof hat") }!
        ])
    }

    if isSunny {
        prepItems.append(contentsOf: [
            PrepItemPresets.items.first { $0.title == String(localized: "Bring sunglasses") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring a hat") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring a water bottle") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring a portable fan") }!
        ])
    }

    if highUVIndex {
        prepItems.append(contentsOf: [
            PrepItemPresets.items.first { $0.title == String(localized: "Bring sunscreen") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring toddler safe sunscreen") }!
        ])
    }

    if isWindy {
        prepItems.append(contentsOf: [
            PrepItemPresets.items.first { $0.title == String(localized: "Bring gloves") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring a scarf") }!
        ])
    }

    if isCold {
        prepItems.append(contentsOf: [
            PrepItemPresets.clothes.first { $0.title == String(localized: "Warm winter coat") }!,
            PrepItemPresets.clothes.first { $0.title == String(localized: "Thermal underwear") }!,
            PrepItemPresets.clothes.first { $0.title == String(localized: "Wool socks") }!,
            PrepItemPresets.items.first { $0.title == String(localized: "Bring a blanket") }!
        ])
    }

    if isHot {
        prepItems.append(contentsOf: [
            PrepItemPresets.clothes.first { $0.title == String(localized: "Short sleeved cotton or linen shirt") }!,
            PrepItemPresets.clothes.first { $0.title == String(localized: "Thigh to knee length pants") }!,
            PrepItemPresets.clothes.first { $0.title == String(localized: "Thick soled shoes or sandals") }!
        ])
    }

    // General items for all conditions
    prepItems.append(contentsOf: [
        PrepItemPresets.items.first { $0.title == String(localized: "Bring snacks") }!,
    ])

    return getDummyPrepItems()
}
