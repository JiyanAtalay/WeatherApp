//
//  WeatherListCellView.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 5.06.2024.
//

import SwiftUI

struct WeatherListCellView: View {
    @State var weather : WeatherModel
    
    var body: some View {
        
        GroupBox {
            VStack {
                HStack {
                    Text(formatDate(timestamp: TimeInterval(weather.dt), timezoneOffset: TimeInterval(weather.timezone)))
                        .font(.title)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("\(weather.name), \(weather.sys.country)")
                        .font(.title3)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                }
                Spacer().frame(height: 25)
                HStack {
                    VStack {
                        Text(String(format: "%.0f", (weather.main.temp)) + " °C")
                            .font(.title)
                        Spacer().frame(height: 5)
                        Text(weather.weather[0].description)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                    }
                    .frame(maxWidth: .infinity , alignment: .leading)

                    AsyncImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: weather.weather[0].icon)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 85, height: 85)
                        case .failure(_):
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 85, height: 85)
                        @unknown default:
                            // Handle unknown future cases
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(maxWidth: .infinity , alignment: .trailing)
                    
                    VStack {
                        HStack {
                            Text("H")
                            Text(Int(weather.main.tempMax).description + "°")
                            Text("/ L")
                            Text(Int(weather.main.tempMin).description + "°")
                        }
                        Spacer().frame(height: 10)
                        Text("Feels like \(String(format: "%.0f", (weather.main.temp)))°")
                    }
                    .frame(maxWidth: .infinity , alignment: .trailing)
                }
                Spacer().frame(height: 25)
                GroupBox {
                    HStack(alignment: .center) {
                        VStack {
                            Text("Wind")
                            Text("\(String(format: "%.1f", (weather.wind.speed)))km")
                        }
                        Spacer().frame(width: 30)
                        VStack {
                            Text("Humidity")
                            Text("\(weather.main.humidity)%")
                        }
                        Spacer().frame(width: 30)
                        VStack {
                            Text("Sunrise")
                            Text(formatDate(timestamp: TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone)))
                        }
                        Spacer().frame(width: 30)
                        VStack {
                            Text("Sunset")
                            Text(formatDate(timestamp: TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone)))
                        }
                    }
                    .frame(maxWidth: .infinity , alignment: .leading)
                }
                Spacer().frame(height: 10)
                HStack {
                    // refresh
                    Button(action: {
                        let webservice = WebService()
                        
                        Task {
                            let newData = try await webservice.downloadWeather(url: Constants.Urls.weatherByCity(city: weather.name))
                            weather = newData
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    }).frame(maxWidth: .infinity, alignment: .leading)
                    
                    // more
                    NavigationLink(destination: CurrentWeatherScreen(weatherName: weather.name)) {
                        Text("More >")
                            .foregroundColor(.white)
                            .padding(8)
                            .frame(width: 85, height: 30)
                            .background(Color.black)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
    }
    
    
    func formatDate(timestamp: TimeInterval, timezoneOffset: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let timezone = TimeZone(secondsFromGMT: Int(timezoneOffset))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }

}

#Preview {
    WeatherListCellView(weather: WeatherModel(coord: Coord(lon: 29.2222, lat: 41.0104), weather: [Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], base: "stations", main: Main(temp: 28.68, feelsLike: 28.21, tempMin: 28.09, tempMax: 28.99, pressure: 1012, humidity: 39), visibility: 10000, wind: Wind(speed: 6.69, deg: 70), clouds: Clouds(all: 0), dt: 1717599358, sys: Sys(type: 1, id: 7018, country: "TR", sunrise: 1717554711, sunset: 1717608706), timezone: 10800, id: 7628420, name: "Sancaktepe", cod: 200))
}
