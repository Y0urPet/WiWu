//
//  ApiClient+GPT.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 11/07/24.
//

import Foundation

extension ApiClient {
    
    func getCurrentLanguageCode() -> String {
        guard let code = Locale.current.language.languageCode?.identifier else {
            print("Could not get the language code")
            return ""
        }
        return code
    }
    
    func buildGptRequest(_ dataStr: String) -> [String: Any] {
        let languageCode = getCurrentLanguageCode()
        var prompt = ""
        
        switch languageCode {
            case "en": // English language
            prompt = """
                Analyze the weather data today and provide a summary. The summary should be one sentences like these, max 3 - 5 words (Perfect for outdoor fun! or Cozy up indoors). Also, recommend the best times (could be multiple) to go out from now until evening of today (8 PM). start_time and end_time should be 1 to 3 hours long. (Use ISO8601)

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
