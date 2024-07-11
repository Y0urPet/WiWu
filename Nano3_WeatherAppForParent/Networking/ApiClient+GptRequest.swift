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
    
    func buildGptRequest() -> [String: Any] {
        let languageCode = getCurrentLanguageCode()
        var prompt = ""
        
        switch languageCode {
            case "en": // English language
                prompt = "Give me a summary on today's weather in three sentences, morning, afternoon and night. Using this format:{\"morning\": \"\", \"afternoon\": \"\", \"evening\": \"\"}"
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
                    "content": "You are a helpful assistant that will sumarize today's weather."
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
