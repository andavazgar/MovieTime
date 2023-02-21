//
//  PartialMovie.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

struct PartialMovie: Movie, Codable {
    var id: Int
    var title: String
    var originalTitle: String
    var overview: String
    var originalLanguage: String
    var releaseDate: Date
    var voteAverage: Double
    var voteCount: Int
    var adult: Bool
    var posterPath: String?
    var backdropPath: String?
}
