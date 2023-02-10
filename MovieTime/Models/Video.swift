//
//  Video.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import Foundation

struct Video: Identifiable, Codable {
    let id: String
    let language: String
    let countryCode: String
    let name: String
    let type: String
    let key: String
    let site: String
    let quality: Int
    let official: Bool
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case language = "iso6391"
        case countryCode = "iso31661"
        case name
        case type
        case key
        case site
        case quality = "size"
        case official
        case publishedAt
    }
}


// MARK: - Extensions
extension Array<Video> {
    func sortedByPriority() -> [Video] {
        var sortedArray = [Video]()
        
        for videoType in VideoTypes.allCases {
            sortedArray += self.filter { $0.type == videoType.rawValue }
        }
        
        return sortedArray
    }
    
    func filtered(by types: [VideoTypes]) -> [Video] {
        let typesAsStrings = types.map(\.rawValue)
        return self.filter { typesAsStrings.contains($0.type) }
    }
}
