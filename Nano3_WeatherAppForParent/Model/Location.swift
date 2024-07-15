//
//  Locations.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 12/07/24.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Location {
    var name: String
    var coords: CLLocation
    
    init(name: String, coords: CLLocation) {
        self.name = name
        self.coords = coords
    }
}
