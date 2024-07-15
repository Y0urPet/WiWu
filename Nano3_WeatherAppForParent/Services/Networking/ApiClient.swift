//
//  ApiClient.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 10/07/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidRequest
}

class ApiClient {
    
    static let shared = ApiClient()
//    
//    func fetchDailySummary() async throws -> Data {
//        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
//            debugPrint("URL invalid")
//            throw APIError.invalidURL
//        }
//        
//        // Construct the request body
//        let requestBody: [String: Any] = buildGptRequest()
//        
//        guard let jsonReqBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
//            print("Failed to serialize JSON")
//            throw APIError.invalidRequest
//        }
//        
//        
//        var req = URLRequest(url: url)
//        req.httpMethod = "POST"
//        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.addValue("Bearer \(ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? "")", forHTTPHeaderField: "Authorization")
//        req.httpBody = jsonReqBody
//        
//        let (data, response) = try await URLSession.shared.data(for: req)
//         
//         guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//             throw URLError(.badServerResponse)
//         }
//         
//         return data
//     }
    
    
    func fetchDailySummary(dataStr: String) async throws -> Data {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            debugPrint("URL invalid")
            throw APIError.invalidURL
        }
        
        // Construct the request body
        let requestBody: [String: Any] = buildGptRequest(dataStr)
        
        guard let jsonReqBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize JSON")
            throw APIError.invalidRequest
        }
        
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("Bearer \(ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? "")", forHTTPHeaderField: "Authorization")
        req.httpBody = jsonReqBody
        
        let (data, response) = try await URLSession.shared.data(for: req)
         
         guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
             throw URLError(.badServerResponse)
         }
         
         return data
     }
}
