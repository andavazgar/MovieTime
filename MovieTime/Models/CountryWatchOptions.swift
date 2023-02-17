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
        Locale.current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    var flag: String {
        /* The base is calculated as such:
         let regionalA = "🇦".unicodeScalars
         let letterA = "A".unicodeScalars
         let base = regionalA[regionalA.startIndex].value - letterA[letterA.startIndex].value */
        let base: UInt32 = 127397
        var flag = ""
        for unicodeScalar in countryCode.unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + unicodeScalar.value)!)
        }
        return flag
    }
}


// MARK: - Extensions
extension Array<CountryWatchOptions> {
    func ordered(by order: [String]) -> [CountryWatchOptions] {
        return self.sorted { (a, b) -> Bool in
            if let first = order.firstIndex(of: a.countryCode), let second = order.firstIndex(of: b.countryCode) {
                return first < second
            }
            return a.name < b.name  // The rest is sorted alphabetically by country name
        }
    }
}
