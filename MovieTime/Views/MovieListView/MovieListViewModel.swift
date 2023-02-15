//
//  MovieListViewModel.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    @Published private(set) var movies = [PartialMovie]()
    
    func getTrendingMovies() async {
        do {
            let movies = try await NetworkingManager.shared.getTrendingMovies()
            
            DispatchQueue.main.async {
                self.movies = movies
            }
        } catch {
            print(error)
        }
    }
}
