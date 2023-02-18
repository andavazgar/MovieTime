//
//  Movie.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

protocol Movie: Identifiable, Codable {
    var id: Int { get }
    var title: String  { get }
    var originalTitle: String  { get }
    var overview: String  { get }
    var originalLanguage: String  { get }
    var releaseDate: Date  { get }
    var voteAverage: Double  { get }
    var voteCount: Int  { get }
    var adult: Bool  { get }
    var posterPath: String?  { get }
    var backdropPath: String?  { get }
    
    // Computed properties
    var releaseYear: String { get }
    var formattedReleaseDate: String { get }
    var rating: Double { get }
    var backdropImageURL: URL? { get }
    var posterImageURL: URL? { get }
}


// MARK: - Extensions
extension Movie {
    var releaseYear: String {
        String(releaseDate.component(.year))
    }
    
    var formattedReleaseDate: String {
        DateFormatter.monthDayYear.string(from: releaseDate)
    }
    
    var rating: Double {
        (voteAverage * 10).rounded() / 10
    }
    
    var backdropImageURL: URL? {
        guard let backdropPath else { return nil }
        return TMDBEndpoint(path: backdropPath).imageURL(ofType: .backdrop)
    }
    
    var posterImageURL: URL? {
        guard let posterPath else { return nil }
        return TMDBEndpoint(path: posterPath).imageURL(ofType: .poster)
    }
}
