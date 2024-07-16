//
//  Extension+Date.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 16/07/24.
//

import Foundation

extension Date {
    func threeLetter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // Set the date format to get the three-letter day code
        
        return dateFormatter.string(from: Date())
    }
}
