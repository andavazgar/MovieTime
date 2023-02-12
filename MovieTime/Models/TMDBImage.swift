//
//  TMDBImage.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-10.
//

import Foundation

struct TMDBImage {
    private static let basePath = "https://image.tmdb.org/t/p/"
    
    static func imageURL(for imagePath: String, ofType type: TMDBImageSizes) -> URL? {
        URL(string: "\(basePath)\(type.rawValue)\(imagePath)")
    }
}

// MARK: - Extensions
extension TMDBImage {
    enum TMDBImageSizes: String {
        case backdrop = "w1280"
        case poster = "w500"
        case logo = "w154"
    }
}
