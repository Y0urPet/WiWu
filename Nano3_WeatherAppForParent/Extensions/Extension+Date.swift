//
//  Extension+Date.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 16/07/24.
//

import Foundation

extension Date {
    
    func threeLetter() -> String {
//        let languageCode = getCurrentLanguageCode()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // Set the date format to get the three-letter day code
        
        return dateFormatter.string(from: self)
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
    func getHourString() -> [String] {
        let languageCode = getCurrentLanguageCode()
        
        switch (languageCode) {
        case "id":
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH.mm"
            let hourString = dateFormatter.string(from: self)
            
            return [hourString, ""]
            
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h a"
            let hourString = dateFormatter.string(from: self)
            let hourArray = hourString.components(separatedBy: " ")
            
            return [hourArray[0], hourArray[1]]
        }

    }
    
    func getHour() -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "HH" // 24-hour format
          return formatter.string(from: self)
        
     
      }
    func getHourMinute() -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "HH.mm" // 24-hour format
          return formatter.string(from: self)
      }
}
