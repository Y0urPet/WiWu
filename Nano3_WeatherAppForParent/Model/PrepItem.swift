//
//  PrepItems.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 15/07/24.
//

import Foundation

import Foundation

enum PrepCategory: String, Codable {
    case clothes
    case items
}

struct PrepItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var category: PrepCategory
    var icon: String
    var priority: UInt16?
    var image: String?
}

