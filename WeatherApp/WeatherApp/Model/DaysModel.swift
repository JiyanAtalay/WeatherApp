//
//  DaysModel.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.06.2024.
//

import Foundation

struct DaysModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [DaysList]
    let city: DaysCity
}

// MARK: - DaysCity
struct DaysCity: Codable {
    let id: Int
    let name: String
    let coord: DaysCoord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - DaysCoord
struct DaysCoord: Codable {
    let lat, lon: Double
}

// MARK: - DaysList
struct DaysList: Codable {
    let dt: Int
    let main: DaysMainClass
    let weather: [DaysWeather]
    let clouds: DaysClouds
    let wind: DaysWind
    let visibility: Int
    let pop: Double
    let sys: DaysSys
    let dtTxt: String
    let rain: DaysRain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - DaysClouds
struct DaysClouds: Codable {
    let all: Int
}

// MARK: - DaysMainClass
struct DaysMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - DaysRain
struct DaysRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - DaysSys
struct DaysSys: Codable {
    let pod: DaysPod
}

enum DaysPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - DaysWeather
struct DaysWeather: Codable {
    let id: Int
    let main: DaysMainEnum
    let description: DaysDescription
    let icon: String
}

enum DaysDescription: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum DaysMainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - DaysWind
struct DaysWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
