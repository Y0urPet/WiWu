//
//  DayWeather.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 11/07/24.
//

import Foundation

struct DayWeather: Identifiable, Decodable, Encodable, Equatable {
    var id = UUID()
    let date: Date
    let condition: String
    let symbolName: String
    let highTemperature: Double
    let lowTemperature: Double
    let precipitation: String
    let precipitationChance: Double
    let precipitationAmount: Double
    let snowfallAmount: Double
    let sun: SunEvents
    let moon: MoonEvents
    let uvIndex: UVIndex
    let wind: Wind
}

struct SunEvents: Decodable, Encodable, Equatable {
    let astronomicalDawn: Date?
    let nauticalDawn: Date?
    let civilDawn: Date?
    let sunrise: Date?
    let solarNoon: Date?
    let sunset: Date?
    let civilDusk: Date?
    let nauticalDusk: Date?
    let astronomicalDusk: Date?
    let solarMidnight: Date?
}

struct MoonEvents: Decodable, Encodable, Equatable {
    let phase: String
    let moonrise: Date?
    let moonset: Date?
}

struct UVIndex: Decodable , Encodable, Equatable{
    let value: Int
    let category: String
}

struct Wind: Decodable , Encodable, Equatable{
    let compassDirection: String
    let direction: Double
    let speed: Double
    let gust: Double?
}
