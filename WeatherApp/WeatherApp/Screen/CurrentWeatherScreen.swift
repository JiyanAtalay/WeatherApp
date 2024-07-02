//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.05.2024.
//

import SwiftUI
import CoreLocation

struct CurrentWeatherScreen: View {
    @StateObject var locationManager = LocationManager()
    @ObservedObject var weatherX = CurrentWeatherViewModel()
    
    @State var weatherName : String?
    
    var body: some View {
        NavigationStack {
            if let weather = weatherX.weather {
                if let weatherDays = weatherX.weatherDays {
                    VStack {
                        VStack {
                            
                            Text(weather.name)
                                .font(.system(size: 20))
                            Text(String(format: "%.0f", (weather.main.temp)) + "°")
                                .font(.system(size: 95))
                            Text(weather.weather[0].main)
                                .font(.system(size: 20))
                            Spacer().frame(height: 10)
                            HStack {
                                Text("H")
                                Text(Int(weather.main.tempMax).description + "°")
                                Text("/ L")
                                Text(Int(weather.main.tempMin).description + "°")
                            }
                            Text("Feels like \(String(format: "%.0f", (weather.main.temp)))°")
                        }
                        Spacer().frame(height: 80)
                        GroupBox {
                            ScrollView(.horizontal) {
                                HStack(spacing: 15) {
                                    ForEach(0..<17) { i in // 40
                                        if (Int(formatDateHour(timestamp: TimeInterval(weatherDays.list[i].dt), timezoneOffset: TimeInterval(weatherDays.city.timezone)))! < 03) {
                                            Divider()
                                                .frame(height: 1)
                                                .background(Color.gray)
                                                .padding(.vertical, 10)
                                        }
                                        GroupBox {
                                            VStack {
                                                Text(formatDateHour(timestamp: TimeInterval(weatherDays.list[i].dt), timezoneOffset: TimeInterval(weatherDays.city.timezone)))
                                                AsyncImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: weatherDays.list[i].weather[0].icon)) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        ProgressView()
                                                            .progressViewStyle(CircularProgressViewStyle())
                                                            .frame(width: 50, height: 50)
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                    case .failure(_):
                                                        Image(systemName: "xmark.circle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                    @unknown default:
                                                        // Handle unknown future cases
                                                        Image(systemName: "questionmark.circle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                    }
                                                }
                                                Text(String(format: "%.0f", (weatherDays.list[i].main.temp)) + "°")
                                            }.font(.system(size: 21))
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .task {
            if let location = locationManager.location {
                Task {
                    await weatherX.downloadWeatherinViewModel(url: Constants.Urls.weatherByLocation(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)))
                    await weatherX.downloadWeathersinViewModel(url: Constants.Urls.weatherByLocationDays(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)))
                }
            }
        }
        .onAppear(perform: {
            locationManager.startUpdatingLocation()
        })
        .onChange(of: locationManager.location) {
            if weatherName == nil {
                if let location = locationManager.location {
                    Task {
                        await weatherX.downloadWeatherinViewModel(url: Constants.Urls.weatherByLocation(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)))
                        await weatherX.downloadWeathersinViewModel(url: Constants.Urls.weatherByLocationDays(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)))
                    }
                }
            } else {
                Task {
                    await weatherX.downloadWeatherinViewModel(url: Constants.Urls.weatherByCity(city: weatherName ?? ""))
                    await weatherX.downloadWeathersinViewModel(url: Constants.Urls.weatherBy5Day(city: weatherName ?? ""))
                }
            }
        }
    }
    
    func formatDateHour(timestamp: TimeInterval, timezoneOffset: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let timezone = TimeZone(secondsFromGMT: Int(timezoneOffset))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "HH"
        
        return dateFormatter.string(from: date)
    }
    
    func formatDateMinute(timestamp: TimeInterval, timezoneOffset: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let timezone = TimeZone(secondsFromGMT: Int(timezoneOffset))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
}

#Preview {
    CurrentWeatherScreen()
}
