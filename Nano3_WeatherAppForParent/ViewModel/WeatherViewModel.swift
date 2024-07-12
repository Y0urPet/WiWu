//
//  WeatherViewModel.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 12/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

@Observable
class WeatherViewModel : WeatherManagerDelegate {
    var currentWeather: CurrentWeather?
    var locationName: String = "Current Location"
    var dailyWeather: [DayWeather] = []
    var hourlyWeather: [HourlyWeather] = []
    
    
    
}
