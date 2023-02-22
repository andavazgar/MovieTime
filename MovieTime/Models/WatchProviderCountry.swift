//
//  WatchProviderCountry.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-21.
//

import Foundation

struct WatchProviderCountry: Codable, Equatable {
    let countryCode: String
    
    var name: String {
        Country.name(for: countryCode)
    }
    
    var flag: String {
        Country.flag(for: countryCode)
    }
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "iso31661"
    }
}
