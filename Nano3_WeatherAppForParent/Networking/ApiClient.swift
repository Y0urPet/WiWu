//
//  ApiClient.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 10/07/24.
//

import Foundation

class ApiClient {
    
    static let shared = ApiClient()
//    
//    func getSummaries() async -> ((Data?)-> Void) {
//        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
//            debugPrint("URL invalid")
//            return
//        }
//        
//        
//        // Construct the request body
//        let requestBody: [String: Any] = [
//            "model": "gpt-4o",
//            "messages": [
//                [
//                    "role": "system",
//                    "content": "You are a helpful assistant that will sumarize today's weather."
//                ],
//                [
//                    "role": "user",
//                    "content": "Give me a summary on todays weather in three sentences, morning, afternoon and night. Also classify is today good or not to go out (true/false). Using this format {'good:' ..., 'summary': ...}"
//                ]
//            ],
//        ]
//        
//        var req = URLRequest(url: url)
//        req.httpMethod = "POST"
//        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.addValue("Bearer \(ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? "")", forHTTPHeaderField: "Authorization")
//        
//        
//        // Create a URL session
//        let session = URLSession.shared
//
//        // Create a data task
//        session.dataTask(with: req) { data, response, error in
//            // Check for errors, then parse the data
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                // Handle HTTP response here
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    //                    print("Response data string:\n \(dataString)")
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        guard let dictionary = json as? [String: Any],
//                              let choices = dictionary["choices"] as? [[String: Any]],
//                              let firstChoice = choices.first,
//                              let message = firstChoice["message"] as? [String: Any],
//                              let content = message["content"] as? String else {
//                            print("Error: Could not parse response data")
//                            return
//                        }
//                            let prompt = "\(content) with a Fun, not too realistic Illustration"
//                        
//                        DispatchQueue.main.async {
//                            completion(prompt)
//                        }
//                        
//                    } catch {
//                        print("Error: Could not parse response JSON")
//                    }
//                }
//            } else {
//                if let response = response as? HTTPURLResponse {
//                    print("HTTP Status Code: \(response.statusCode)")
//                }
//            }
//            
//        }
//        .resume()
//    }
}
