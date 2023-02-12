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
