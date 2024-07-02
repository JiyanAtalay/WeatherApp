//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.05.2024.
//

import Foundation

struct WeatherModel: Codable, Hashable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    private enum CodingKeys : String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

struct Clouds: Codable, Hashable {
    let all: Int
}

struct Coord: Codable, Hashable {
    let lon, lat: Double
}

struct Main: Codable, Hashable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Sys: Codable, Hashable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable, Hashable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Int
}
