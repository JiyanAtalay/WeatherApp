//
//  WebService.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.05.2024.
//

import Foundation
import SwiftUI

class WebService {
    func downloadWeather(url : URL) async throws -> WeatherModel {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            return weather
        } catch _ as DecodingError {
            throw WeatherError.decodingError
        } catch {
            throw WeatherError.networkError(error)
        }
    }
    
    func downloadWeatherList(liste : [DatabaseModel]) async throws -> [WeatherModel] {
        var weatherList = [WeatherModel]()
        
        for element in liste {
            
            do {
                let (data, _) = try await URLSession.shared.data(from: Constants.Urls.weatherByCity(city: element.name))
                
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                
                weatherList.append(weather)
            } catch _ as DecodingError {
                throw WeatherError.decodingError
            } catch {
                throw WeatherError.networkError(error)
            }
        }
        return weatherList
    }
    
    func downloadWeatherDays(url : URL) async throws -> DaysModel {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let weather = try JSONDecoder().decode(DaysModel.self, from: data)
            
            return weather
        } catch _ as DecodingError {
            throw WeatherError.decodingError
        } catch {
            throw WeatherError.networkError(error)
        }
    }
}


enum WeatherError: Error {
    case decodingError
    case networkError(Error)
}
