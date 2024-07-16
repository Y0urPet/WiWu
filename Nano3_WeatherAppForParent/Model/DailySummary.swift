//
//  SummaryModel.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 10/07/24.

import Foundation


struct BestTime: Decodable, Encodable, Equatable {
    let startTime: Date
    let endTime: Date
    
    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case endTime = "end_time"
    }

    // Custom decoding to parse the date strings
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startTimeString = try container.decode(String.self, forKey: .startTime)
        let endTimeString = try container.decode(String.self, forKey: .endTime)
        
        // Create a DateFormatter to parse the date strings
        let dateFormatter = ISO8601DateFormatter()
        
        // Parse the start and end times
        guard let startTime = dateFormatter.date(from: startTimeString),
              let endTime = dateFormatter.date(from: endTimeString) else {
            throw DecodingError.dataCorruptedError(forKey: .startTime,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        
        self.startTime = startTime
        self.endTime = endTime
    }
}


struct DailySummary:  Decodable, Encodable, Equatable {
    static func == (lhs: DailySummary, rhs: DailySummary) -> Bool {
        return lhs.morning == rhs.morning &&
            lhs.afternoon == rhs.afternoon &&
            lhs.evening == rhs.evening &&
            lhs.scoreOutOfTen == rhs.scoreOutOfTen &&
            lhs.bestTimes == rhs.bestTimes &&
            lhs.summary == rhs.summary &&
            lhs.summaryAlt == rhs.summaryAlt &&
            lhs.prepItems == rhs.prepItems
    }
    var morning: String?
    var afternoon: String?
    var evening: String?
    var scoreOutOfTen: Int
    var bestTimes: [BestTime]
    var summary: String
    var summaryAlt: String
    var prepItems: [PrepItem] = []
    
    // Save a copy of ApiClient
    let apiClient = ApiClient.shared
    
    enum CodingKeys: String, CodingKey {
        case scoreOutOfTen = "score_out_of_ten"
        case bestTimes = "best_times"
        case summary = "summary"
        case summaryAlt = "summary_alt"
    }
}

extension DailySummary: CustomStringConvertible {
    var description: String {
        return "\nsum:\(summary)\nalt:\(summaryAlt)\ntimes:\(bestTimes)"
    }
}
