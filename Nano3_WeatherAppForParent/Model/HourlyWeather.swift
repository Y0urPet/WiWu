//
//  HourlyWeather.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 11/07/24.
//

import Foundation

struct HourlyWeather: Identifiable, Decodable, Encodable, Equatable {
    var id = UUID()
    var date: Date
    let cloudCover: Double
//        let cloudCoverLow: Double
//        let cloudCoverMid: Double
//        let cloudCoverHigh: Double
    let condition: String
    let symbolName: String
    let dewPoint: Double
    let humidity: Double
    let isDaylight: Bool
    let precipitation: String
    let precipitationChance: Double
    let precipitationAmount: Double
//        let snowfallAmount: Double
    let pressure: Double
    let pressureTrend: String
    let temperature: Double
    let apparentTemperature: Double
    let uvIndex: UVIndex
    let visibility: Double
    let wind: Wind

    struct UVIndex : Decodable, Encodable, Equatable {
        let value: Int
        let category: String
    }

    struct Wind : Decodable, Encodable, Equatable{
        let compassDirection: String
        let direction: Double
        let speed: Double
        let gust: Double?
    }
}
