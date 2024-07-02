//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.05.2024.
//

import Foundation
import SwiftUI
 
class CurrentWeatherViewModel : ObservableObject {
    
    @Published var weather : WeatherModel?
    @Published var weatherDays : DaysModel?
    
    let webservice = WebService()
    
    func downloadWeatherinViewModel(url : URL) async {
        do {
            let weather2 = try await webservice.downloadWeather(url: url)
            
            DispatchQueue.main.async {
                self.weather = weather2
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func downloadWeathersinViewModel(url: URL) async {
        do {
            let weather2 = try await webservice.downloadWeatherDays(url: url)
            
            
            DispatchQueue.main.async {
                self.weatherDays = weather2
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
