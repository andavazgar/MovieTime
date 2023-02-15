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
    var posterPath: String  { get }
    var backdropPath: String  { get }
}


// MARK: - Extensions
extension Movie {
    var releaseYear: String {
        String(releaseDate.component(.year))
    }
    
    var formattedReleaseDate: String {
        DateFormatter.monthDayYear.string(from: releaseDate)
    }
    
    var rating: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: voteAverage))!
    }
}
