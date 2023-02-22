//
//  SettingsView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                listOfChosenCountries
                listOfCountries
            }
            .navigationTitle("Settings")
        }
        .task {
            await vm.getWatchProviderCountries()
        }
    }
    
    private var listOfChosenCountries: some View {
        Section {
            ForEach(vm.chosenCountries, id:\.countryCode) { country in
                HStack {
                    Text("\(country.flag) \(country.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .onMove(perform: vm.moveCountries)
            .onDelete(perform: vm.deleteCountries)
        } header: {
            Text("Chosen Countries")
        } footer: {
            Text("The chosen countries will be used to populate the \"Where to Watch\" section of movies.")
        }
    }
    
    private var listOfCountries: some View {
        Section {
            ForEach(vm.countries, id:\.countryCode) { country in
                HStack {
                    Text("\(country.flag) \(country.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if vm.chosenCountries.contains { $0 == country } {
                        Image(systemName: "checkmark")
                    }
                }
                .onTapGesture {
                    withAnimation {
                        vm.toggleChosenCountry(country)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
