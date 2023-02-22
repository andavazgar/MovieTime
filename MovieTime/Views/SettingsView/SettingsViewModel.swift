//
//  SettingsViewModel.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-21.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published private(set) var countries = [WatchProviderCountry]()
    @Published private(set) var chosenCountries = [WatchProviderCountry]() {
        didSet {
            if loadedUserDefaults {
                // Persist value in UserDefaults
                UserDefaults.standard.setValue(chosenCountries, forKey: AppStorageKeys.chosenCountries)
            }
        }
    }
    private var loadedUserDefaults = false
    
    init() {
        loadUserDefaults()
        loadedUserDefaults = true
    }
    
    private func loadUserDefaults() {
        if let storedArray = UserDefaults.standard.getValue(valueOfType: [WatchProviderCountry].self, forKey: AppStorageKeys.chosenCountries) {
            chosenCountries = storedArray
        }
    }
    
    func toggleChosenCountry(_ chosenCountry: WatchProviderCountry) {
        if let index = chosenCountries.firstIndex(where: { $0 == chosenCountry }) {
            chosenCountries.remove(at: index)
        } else {
            chosenCountries.append(chosenCountry)
        }
    }
    
    func moveCountries(from source: IndexSet, to destination: Int) {
        chosenCountries.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteCountries(from source: IndexSet) {
        chosenCountries.remove(atOffsets: source)
    }
    
    @MainActor
    func getWatchProviderCountries() async {
        do {
            countries = try await NetworkingManager.shared.getWatchProviderCountries()
        } catch {
            print(error)
        }
    }
}
