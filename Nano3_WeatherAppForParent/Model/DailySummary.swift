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
    
    let apiClient = ApiClient.shared
    
    init() {
        
        self.morning = ""
        self.afternoon = ""
        self.evening = ""
    }
}
