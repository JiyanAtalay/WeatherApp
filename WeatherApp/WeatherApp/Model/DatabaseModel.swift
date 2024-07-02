//
//  DatabaseModel.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 2.06.2024.
//

import Foundation
import SwiftData

@Model
class DatabaseModel : Identifiable{
    let id : UUID = UUID()
    var name : String
    var timestamp : Date
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
    }
}
