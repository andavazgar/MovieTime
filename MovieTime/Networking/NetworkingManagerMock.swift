//
//  NetworkingManagerMock.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

final class NetworkingManagerMock {
    private static let tmdbDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategyFormatters = [.yearMonthDay]
        return decoder
    }()
    
    private static func getJSONData(for fileName: String) -> Data? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json"),
              let data = FileManager.default.contents(atPath: filePath)
        else {
            print("Could not find path for resource: \(fileName).json")
            return nil
        }
        
        return data
    }
    
    static func getTrendingMovies() -> [Movie] {
        let fileName = "TrendingMovies"
        guard let data = getJSONData(for: fileName) else {
            return []
        }
        
        do {
            let movies = try tmdbDecoder.decode(MoviesResponse.self, from: data)
            return movies.results
        } catch {
            dump(error)
            return []
        }
    }
    
    static func getMovie(withId id: Int, including appendedResponse: [AppendToResponse]? = nil) -> Movie? {
        let fileName = appendedResponse == nil ? "Movie" : "MovieWithAppendedResponse"
        guard let data = getJSONData(for: fileName) else {
            return nil
        }
        
        do {
            return try tmdbDecoder.decode(Movie.self, from: data)
        } catch {
            dump(error)
            return nil
        }
    }
}
