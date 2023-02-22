//
//  Country.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-21.
//

import Foundation

struct Country {
    static func name(for countryCode: String) -> String {
        Locale.current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    static func flag(for countryCode: String) -> String {
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
