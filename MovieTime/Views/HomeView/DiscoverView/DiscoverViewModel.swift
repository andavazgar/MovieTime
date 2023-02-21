//
//  DiscoverViewModel.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

final class DiscoverViewModel: ObservableObject {
    @Published private(set) var trendingMovies = [PartialMovie]()
    @Published private(set) var nowPlayingMovies = [PartialMovie]()
    @Published private(set) var upcomingMovies = [PartialMovie]()
    
    @MainActor
    func getTrendingMovies() async {
        do {
            trendingMovies = try await NetworkingManager.shared.getTrendingMovies()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func getNowPlayingMovies() async {
        do {
            nowPlayingMovies = try await NetworkingManager.shared.getNowPlayingMovies()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func getUpcomingMovies() async {
        do {
            upcomingMovies = try await NetworkingManager.shared.getUpcomingMovies()
        } catch {
            print(error)
        }
    }
}
