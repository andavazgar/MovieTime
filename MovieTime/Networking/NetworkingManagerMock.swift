//
//  NetworkingManagerMock.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

final class NetworkingManagerMock {
    static let shared = NetworkingManagerMock()
    private let tmdbDecoder = NetworkingManager.shared.tmdbDecoder
    private var cache = [URL: Data]()
    
    private init() {}
    
    private func getJSONData(for fileName: String) -> Data? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json"),
              let data = FileManager.default.contents(atPath: filePath)
        else {
            print("Could not find path for resource: \(fileName).json")
            return nil
        }
        
        return data
    }
    
    func getTrendingMovies() -> [PartialMovie] {
        let fileName = "TrendingMovies"
        guard let data = getJSONData(for: fileName) else {
            return []
        }
        
        do {
            let movies = try tmdbDecoder.decode(PartialMoviesResponse.self, from: data)
            return movies.results
        } catch {
            dump(error)
            return []
        }
    }
    
    func getMovie(withId id: Int, including appendedResponse: [TMDBEndpoint.AppendToResponse]? = nil) -> DetailedMovie? {
        let fileName = appendedResponse == nil ? "Movie" : "MovieWithAppendedResponse"
        guard let data = getJSONData(for: fileName) else {
            return nil
        }
        
        do {
            return try tmdbDecoder.decode(DetailedMovie.self, from: data)
        } catch {
            dump(error)
            return nil
        }
    }
}
