//
//  WeathersListView.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 2.06.2024.
//

import SwiftUI
import SwiftData

struct WeathersListScreen: View {
    @StateObject var weatherX = WeatherListViewModel()
    @StateObject var weatherY = CurrentWeatherViewModel()
    @StateObject var dataModel = DataModel()
    
    @Environment(\.modelContext) private var context
    @Query(sort: \DatabaseModel.timestamp, order: .forward) private var weathers : [DatabaseModel]

    @State private var showAddView = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("City's")
                        .font(.largeTitle)
                        .frame(alignment: .center)
                    Spacer()
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 25,height: 30)
                        .padding()
                }
                
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    ForEach(weatherX.weatherList,id: \.self) { element in
                        
                            WeatherListCellView(weather: element)
                                .padding(-5)
                        
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let weather = weathers[index]
                            context.delete(weather)
                            
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    })
                }
            }
            .padding(-15)
            .toolbar(content: {
                Button {
                    showAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            })
            .sheet(isPresented: $showAddView, onDismiss: {
                Task {
                    await weatherY.downloadWeatherinViewModel(url:Constants.Urls.weatherByCity(city: dataModel.text))
                    if let addedData = weatherY.weather {
                        weatherX.weatherList.append(addedData)
                        context.insert(DatabaseModel(name: dataModel.text))
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        dataModel.text = ""
                    }
                }
            }, content: {
                NavigationStack {
                    AddScreen(dataModel: dataModel)
                }
            })
        }
        .onAppear(perform: {
            Task {
                isLoading = true
                await weatherX.downloadWeatherList(liste:weathers)
                isLoading = false
            }
            
            Timer.scheduledTimer(withTimeInterval: 200, repeats: true) { timer in
                Task.init {
                    isLoading = true
                    await weatherX.downloadWeatherList(liste:weathers)
                    isLoading = false
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        WeathersListScreen()
    }.modelContainer(for: [DatabaseModel.self])
}
