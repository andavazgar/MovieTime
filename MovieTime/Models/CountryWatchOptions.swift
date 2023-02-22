//
//  CountryWatchOptions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-11.
//

import Foundation

struct CountryWatchOptions {
    let countryCode: String
    let watchOptions: WatchOptions
    
    var name: String {
        Country.name(for: countryCode)
    }
    
    var flag: String {
        Country.flag(for: countryCode)
    }
}


// MARK: - Extensions
extension Array<CountryWatchOptions> {
    func ordered(by order: [String]?) -> [CountryWatchOptions] {
        return self.sorted { (a, b) -> Bool in
            if let first = order?.firstIndex(of: a.countryCode), let second = order?.firstIndex(of: b.countryCode) {
                return first < second
            }
            return a.name < b.name  // The rest is sorted alphabetically by country name
        }
    }
}
