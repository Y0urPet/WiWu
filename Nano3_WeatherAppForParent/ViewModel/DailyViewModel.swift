//
//  DailyViewModel.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 10/07/24.
//

import Foundation

@Observable
class DailyViewModel {
    
    let apiClient = ApiClient.shared
    var dailySummary: DailySummary?
    
    init() async {
        self.dailySummary = nil
//        Task {
//            await loadDailySummary()
//        }
    }
    
//    func loadDailySummary() async {
//        do {
//            let data = try await apiClient.fetchDailySummary()
//            DispatchQueue.main.async {
//                self.dailySummary = DailySummary(data: data)
//                debugPrint(self.dailySummary ?? "?")
//            }
//        } catch {
//            // Handle error
//        }
//    }
}
