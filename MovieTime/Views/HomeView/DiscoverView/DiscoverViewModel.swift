//
//  DiscoverViewModel.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

final class DiscoverViewModel: ObservableObject {
    @Published private(set) var movies = [PartialMovie]()
    
    @MainActor
    func getTrendingMovies() async {
        do {
            self.movies = try await NetworkingManager.shared.getTrendingMovies()
        } catch {
            print(error)
        }
    }
}
