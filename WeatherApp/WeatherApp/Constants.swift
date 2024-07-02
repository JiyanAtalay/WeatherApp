//
//  Constants.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.05.2024.
//

import Foundation

struct Constants {
    struct Urls {
        static func weatherByCity(city: String) -> URL {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=?&units=metric")!
        }
        
        static func weatherByLocation(latitude: String, longitude: String) -> URL {
            return URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=?&units=metric")!
        }
        
        static func weatherByLocationDays(latitude: String, longitude: String) -> URL {
            return URL(string:"https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=?&units=metric")!
        }
        
        static func weatherBy5Day(city: String) -> URL {
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=?&units=metric")!
        }
        
        static func weatherUrlAsStringByIcon(icon: String) -> URL {
            return URL(string: "https://openweathermap.org/img/w/\(icon).png")!
        }
    }
}
