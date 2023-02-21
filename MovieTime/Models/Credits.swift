//
//  Credits.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-20.
//

import Foundation

struct Credits: Codable {
    let cast: [Cast]
    
    struct Cast: Codable, Identifiable {
        let id: Int
        let character: String
        let name: String
        let originalName: String
        let gender: Int
        let knownForDepartment: String
        let popularity: Double
        let profilePath: String?
        let adult: Bool
        let order: Int
    }
}
