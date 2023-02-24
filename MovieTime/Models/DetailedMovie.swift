//
//  Movie.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

struct DetailedMovie: Movie, Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let originalLanguage: String
    let releaseDate: Date?
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
    let credits: Credits
}


// MARK: - Extensions
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
        case credits
    }
    
    init(from decoder: Decoder) throws {
        // try? for releaseDate because sometimes the string can be empty instead of having a date or being nil
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.releaseDate = try? container.decodeIfPresent(Date.self, forKey: .releaseDate)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.genres = try container.decodeIfPresent([DetailedMovie.Genre].self, forKey: .genres)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.releaseDates = try container.decodeIfPresent(AppendedResults<[ReleaseSchedule]>.self, forKey: .releaseDates)
        self.watchProviders = try container.decodeIfPresent(AppendedResults<[String : WatchOptions]>.self, forKey: .watchProviders)
        self.videos = try container.decodeIfPresent(AppendedResults<[Video]>.self, forKey: .videos)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.credits = try container.decode(Credits.self, forKey: .credits)
    }
}

// MARK: - Genre
extension DetailedMovie {
    struct Genre: Identifiable, Codable {
        let id: Int
        let name: String
    }
}
