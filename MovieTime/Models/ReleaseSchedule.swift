//
//  ReleaseSchedule.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import Foundation

struct ReleaseSchedule: Codable {
    let countryCode: String
    let releaseDates: [Release]
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "iso31661"
        case releaseDates
    }
    
    struct Release: Codable {
        let certification: String
        let note: String
        let releaseDate: String
        let type: Int
    }
}
