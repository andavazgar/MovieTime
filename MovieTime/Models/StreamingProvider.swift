//
//  StreamingProvider.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-10.
//

import Foundation

struct StreamingProvider: Identifiable, Codable {
    let id: Int
    let name: String
    let logoPath: String
    let displayPriority: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "providerId"
        case name = "providerName"
        case logoPath
        case displayPriority
    }
}
