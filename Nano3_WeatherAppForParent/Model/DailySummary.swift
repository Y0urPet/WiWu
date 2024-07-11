//
//  SummaryModel.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 10/07/24.
//

import Foundation

struct DailySummary {
    let morning: String
    let afternoon: String
    let evening: String
    
    // Save a copy of ApiClient
    let apiClient = ApiClient.shared
    
    // Do some data (type Data) parsing in init
    init(data: Data) {
        do {
            let json: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dictionary = json as? [String: Any],
                  let choices = dictionary["choices"] as? [[String: Any]],
                  let firstChoice = choices.first,
                  let message = firstChoice["message"] as? [String: Any],
                  let content = message["content"] as? String,
                  let weatherData = try? JSONSerialization.jsonObject(with: Data(content.utf8), options: []) as? [String: String] else {
                
                self.morning = ""
                self.afternoon = ""
                self.evening = ""
                
                return
            }
            
            self.morning = weatherData["morning"] ?? ""
            self.afternoon = weatherData["afternoon"] ?? ""
            self.evening = weatherData["evening"] ?? ""
        }
        catch {
            self.morning = ""
            self.afternoon = ""
            self.evening = ""
            debugPrint("Error: Initializing DailySummary model")
        }
    }
}

extension DailySummary: CustomStringConvertible {
    var description: String {
        return "\nMorning: \(morning)\nAfternoon: \(afternoon)\nEvening: \(evening)\n"
    }
}
