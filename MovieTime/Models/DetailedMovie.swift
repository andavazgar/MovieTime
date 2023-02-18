//
//  Movie.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

struct DetailedMovie: Movie {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let originalLanguage: String
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    let genres: [Genre]?
    let runtime: Int
    let releaseDates: AppendedResults<[ReleaseSchedule]>?
    let watchProviders: AppendedResults<[String: WatchOptions]>?
    let videos: AppendedResults<[Video]>?
    let adult: Bool
    let posterPath: String?
    let backdropPath: String?
}


// MARK: - Extensions
// MARK: - CodingKeys
extension DetailedMovie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle
        case overview
        case originalLanguage
        case releaseDate
        case voteAverage
        case voteCount
        case genres
        case runtime
        case releaseDates
        case watchProviders = "watch/providers"
        case videos
        case adult
        case posterPath
        case backdropPath
    }
}

// MARK: - Genre
extension DetailedMovie {
    struct Genre: Identifiable, Codable {
        let id: Int
        let name: String
    }
}
