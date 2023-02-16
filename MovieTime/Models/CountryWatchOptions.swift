//
//  CountryWatchOptions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-11.
//

import Foundation

struct CountryWatchOptions {
    let name: String
    let watchOptions: WatchOptions
    
    var flag: String {
        switch name {
        case "CA":
            return "🇨🇦"
        case "US":
            return "🇺🇸"
        default:
            return name
        }
    }
}


// MARK: - Extensions
extension Array<CountryWatchOptions> {
    func ordered(by order: [String]) -> [CountryWatchOptions] {
        return self.sorted { (a, b) -> Bool in
            if let first = order.firstIndex(of: a.name), let second = order.firstIndex(of: b.name) {
                return first < second
            }
            return a.name < b.name  // The rest is sorted alphabetically by country name
        }
    }
}
