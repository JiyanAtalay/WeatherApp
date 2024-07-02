//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 30.05.2024.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainScreen()
                    .preferredColorScheme(.light)
            }
        }.modelContainer(for: [DatabaseModel.self])
    }
}
