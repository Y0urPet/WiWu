//
//  WeatherManagerProtocol.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 12/07/24.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func getWeather(daily: [DayWeather], hourly: [HourlyWeather])
}
