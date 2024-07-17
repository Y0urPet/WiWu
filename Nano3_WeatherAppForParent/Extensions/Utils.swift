//
//  Utils.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 17/07/24.
//

import Foundation


func getCurrentLanguageCode() -> String {
    guard let code = Locale.current.language.languageCode?.identifier else {
        print("Could not get the language code")
        return ""
    }
    return code
}
