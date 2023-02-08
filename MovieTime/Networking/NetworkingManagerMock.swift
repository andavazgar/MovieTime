//
//  NetworkingManagerMock.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

struct NetworkingManagerMock {
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
            print("No data was found in \(fileName) file")
            return []
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let movies = try decoder.decode(MoviesResponse.self, from: data)
            return movies.results
        } catch {
            print(error)
            return []
        }
    }
}
