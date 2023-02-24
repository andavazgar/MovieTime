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
    var releaseDate: Date?
    var voteAverage: Double
    var voteCount: Int
    var adult: Bool
    var posterPath: String?
    var backdropPath: String?
}


extension PartialMovie {
    // try? for releaseDate because sometimes the string can be empty instead of having a date or being nil
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.releaseDate = try? container.decodeIfPresent(Date.self, forKey: .releaseDate)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
    }
}
