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
    private let releaseDate: String
    private let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]
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
    
    var releasedDate: String {
        DateFormatter.changeDateFormat(dateString: releaseDate, fromFormat: "yyyy-MM-dd", toFormat: "MMMM d, yyyy")
    }
    
    var rating: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: voteAverage))!
    }
}
