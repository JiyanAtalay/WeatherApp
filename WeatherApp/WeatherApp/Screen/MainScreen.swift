//
//  MainView.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 2.06.2024.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        TabView() {
            CurrentWeatherScreen()
                .tabItem {
                    Label("Weather", systemImage: "location.circle.fill")
                }
            WeathersListScreen()
                .tabItem {
                    Label("List", systemImage: "magnifyingglass.circle.fill")
                }
                .modelContainer(for:[DatabaseModel.self])
        }
    }
}

#Preview {
    NavigationStack {
        MainScreen()
    }.modelContainer(for:[DatabaseModel.self])
}
