//
//  Movie.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let originalLanguage: String
    let releaseDate: Date
    private let voteAverage: Double
    let voteCount: Int
    let genres: [Genre]?
    let runtime: Int
    let releaseDates: AppendedResults<[ReleaseSchedule]>?
    let watchProviders: AppendedResults<[String: WatchOptions]>?
    let videos: AppendedResults<[Video]>?
    let adult: Bool
    let posterPath: String
    let backdropPath: String
    
    private static let imagesBaseURL = "https://image.tmdb.org/t/p/"
    private static let posterWidth = "w500"
    private static let backdropWidth = "w1280"
    
    var fullPosterPath: String {
        "\(Movie.imagesBaseURL)\(Movie.posterWidth)\(posterPath)"
    }
    
    var fullBackdropPath: String {
        "\(Movie.imagesBaseURL)\(Movie.backdropWidth)\(posterPath)"
    }
    
    var formattedRuntime: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: DateComponents(minute: runtime)) ?? ""
    }
    
    var formattedReleaseDate: String {
        DateFormatter.monthDayYear.string(from: releaseDate)
    }
    
    var contentRating: String {
        guard let releasesForUS = releaseDates?.results.filter({ $0.countryCode == "US"}).first,
              let theatricalRelease = releasesForUS.releaseDates.filter({ $0.type == ReleaseDateTypes.Theatrical.rawValue }).first
        else {
            return ""
        }
        
        return theatricalRelease.certification
    }
    
    var watchOptions: [CountryWatchOptions]? {
        let countries = ["CA", "US"]
        return watchProviders?.results
            .filter { countries.contains($0.key) }
            .map { CountryWatchOptions(name: $0.key, watchOptions: $0.value) }
    }
    
    var mainVideos: [Video]? {
        return self.videos?.results.filtered(by: [.Trailer, .Teaser]).sortedByPriority()
    }
    
    var rating: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: voteAverage))!
    }
}


// MARK: - Extensions
// MARK: - CodingKeys
extension Movie {
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
extension Movie {
    struct Genre: Identifiable, Codable {
        let id: Int
        let name: String
    }
}
