//
//  Extension+Double.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 17/07/24.
//

import Foundation
extension Double{
    func formattedTemperature() -> String {
        return String(format: "%.0f°", self)
    }
}

