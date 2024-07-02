//
//  AddView.swift
//  WeatherApp
//
//  Created by Mehmet Jiyan Atalay on 1.06.2024.
//

import SwiftUI

struct AddScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dataModel: DataModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField(text: $dataModel.text) {
                    Text("City name")
                }
                .frame(width: 200,height: 35)
                .border(Color.black)
                
                Button(action: {
                    Task {
                        if validateInput() {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }, label: {
                    Text("Find the City")
                })
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func validateInput() -> Bool {
        guard !dataModel.text.isEmpty else {
            alertMessage = "City name cannot be empty."
            showAlert = true
            return false
        }
        return true
    }
}


class DataModel: ObservableObject {
    @Published var text: String = ""
}

#Preview {
    AddScreen(dataModel: DataModel()).modelContainer(for: [DatabaseModel.self])
}
