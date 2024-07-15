//
//  +Date.swift
//  Nano3_WeatherAppForParent
//
//  Created by Rama Eka Hartono on 15/07/24.
//

import Foundation

extension Date {
    func getHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH" // 24-hour format
        return formatter.string(from: self)
    }
}
