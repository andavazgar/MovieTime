//
//  TMDBEndpoint.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

struct TMDBEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}


// MARK: - Extensions
extension TMDBEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/\(path)"
        components.queryItems = queryItems + [
            URLQueryItem(name: "api_key", value: Keys.TMDB_API_KEY)
        ]
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    func imageURL(ofType type: TMDBImageTypes) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p/\(type.rawValue)/\(path)"
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    static var getTrendingMovies: Self {
        TMDBEndpoint(path: "trending/movie/day")
    }
    
    static var getNowPlayingMovies: Self {
        TMDBEndpoint(path: "/movie/now_playing", queryItems: [
            URLQueryItem(name: "region", value: "US")
        ])
    }
    
    static var getUpcomingMovies: Self {
        TMDBEndpoint(path: "/movie/upcoming", queryItems: [
            URLQueryItem(name: "region", value: "US")
        ])
    }
    
    static func getMovie(withId id: Int, including appendedResponse: [AppendToResponse] = []) -> Self {
        TMDBEndpoint(path: "movie/\(id)", queryItems: appendedResponse.queryItems)
    }
    
    static func searchMovies(with searchTerm: String) -> Self {
        TMDBEndpoint(path: "search/movie", queryItems: [
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "include_adult", value: "false")
        ])
    }
    
    
    // MARK: - AppendToResponse
    enum AppendToResponse: String {
        case images
        case releaseDates = "release_dates"
        case streamingProviders = "watch/providers"
        case videos
        case credits
    }
}


// MARK: - Array<AppendToResponse>
extension Array<TMDBEndpoint.AppendToResponse> {
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "append_to_response", value: self.map({ $0.rawValue }).joined(separator: ","))]
    }
}
