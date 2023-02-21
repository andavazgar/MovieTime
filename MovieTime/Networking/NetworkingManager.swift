//
//  NetworkingManager.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    let tmdbDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategyFormatters = [.yearMonthDay]
        return decoder
    }()
    private var cache = [URL: Data]()
    
    private init() {}
    
    private func fetchData(with url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.setValue(Keys.TMDB_API_KEY, forHTTPHeaderField: "api_key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkError.invalidResponse(response: response, data: String(data: data, encoding: .utf8) ?? "")
        }
        
        return data
    }
    
    
    func getTrendingMovies() async throws -> [PartialMovie] {
        let url = TMDBEndpoint.getTrendingMovies.url
        let data = try await fetchData(with: url)
        
        let response = try tmdbDecoder.decode(PartialMoviesResponse.self, from: data)
        return response.results
    }
    
    func getNowPlayingMovies() async throws -> [PartialMovie] {
        let url = TMDBEndpoint.getNowPlayingMovies.url
        let data = try await fetchData(with: url)
        
        let response = try tmdbDecoder.decode(PartialMoviesResponse.self, from: data)
        return response.results
    }
    
    func getUpcomingMovies() async throws -> [PartialMovie] {
        let url = TMDBEndpoint.getUpcomingMovies.url
        let data = try await fetchData(with: url)
        
        let response = try tmdbDecoder.decode(PartialMoviesResponse.self, from: data)
        return response.results
    }
    
    func getMovie(withId id: Int, including appendedResponse: [TMDBEndpoint.AppendToResponse] = []) async throws -> DetailedMovie {
        let url = TMDBEndpoint.getMovie(withId: id, including: appendedResponse).url
        let data = try await fetchData(with: url)
        
        return try tmdbDecoder.decode(DetailedMovie.self, from: data)
    }
    
    func searchMovies(with searchTerm: String) async throws -> [PartialMovie] {
        let url = TMDBEndpoint.searchMovies(with: searchTerm).url
        let data = try await fetchData(with: url)
        
        let response = try tmdbDecoder.decode(PartialMoviesResponse.self, from: data)
        return response.results
    }
}


// MARK: - Extensions
// MARK: - NetworkingError
extension NetworkingManager {
    enum NetworkError: Error {
        case invalidResponse(response: HTTPURLResponse, data: String)
    }
}
