//
//  HomeViewModel.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-16.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var movies = [PartialMovie]()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(searchTerm: String? = nil) {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { searchTerm in
                Task { [weak self] in
                    await self?.searchMovies(with: searchTerm)
                }
            }
            .store(in: &subscriptions)
        
        // Used for preview
        if let searchTerm {
            self.searchTerm = searchTerm
        }
    }
    
    @MainActor
    private func searchMovies(with searchTerm: String) async {
        do {
            movies = try await NetworkingManager.shared.searchMovies(with: searchTerm)
        } catch {
            print(error)
        }
    }
}
