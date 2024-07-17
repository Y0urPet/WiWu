//
//  ApiClient+GPT.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 11/07/24.
//

import Foundation

extension ApiClient {
    
    func buildGptRequest(_ dataStr: String) -> [String: Any] {
        let languageCode = getCurrentLanguageCode()
        var prompt = ""
        
        switch languageCode {
            case "en": // English language
            prompt = """
                Analyze the weather data you are given and provide a summary. The summary should be one sentences like these, max 5 words (for example: Perfect for outdoor fun! or Cozy up indoors), that recommends the user best to go out or not. Also, recommend the best times (could be multiple) to go out from now until evening of today (8 PM). start_time and end_time should be 1 to 3 hours long. (Use ISO8601)

                Output format:
                {
                  "summary": "string",
                  "summary_alt": "string",
                  "score_out_of_ten: Int
                  "best_times": [
                    {
                      "start_time": "string",
                      "end_time": "string"
                    },
                    {
                        ...
                    }
                  ]
                }
            """
            case "id": // Bahasa Indonesia language (id for Indonesian)
              prompt = "Berikan ringkasan cuaca hari ini dalam tiga kalimat, pagi, siang, dan malam. Menggunakan format ini:{\"morning\": \"\", \"afternoon\": \"\", \"evening\": \"\"}. Jangan ubah bahasa dari morning, afternoon, dan evening"
            default:
              print("Unsupported language code: \(languageCode)")
              // Handle unsupported language gracefully (e.g., set default content)
        }

        // Construct the request body
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "system",
                    "content": "You are a helpful assistant that will sumarize today's weather. Here is today's weather: \(dataStr)"
                ],
                [
                    "role": "user",
                    "content": "\(prompt)"
                ]
            ],
        ]
        
        return requestBody
    }
    
}
