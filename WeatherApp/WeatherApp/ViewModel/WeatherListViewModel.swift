//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 2.06.2024.
//

import Foundation
import SwiftUI

class WeatherListViewModel : ObservableObject {
    
    @Published var weatherList = [WeatherModel]()
    
    let webservice = WebService()
    
    func downloadWeatherList(liste : [DatabaseModel]) async {
        do {
            let weathers = try await webservice.downloadWeatherList(liste: liste)
            
            DispatchQueue.main.async {
                self.weatherList = weathers
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
