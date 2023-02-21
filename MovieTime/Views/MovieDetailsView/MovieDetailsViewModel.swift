//
//  MovieDetailsViewModel.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-14.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    @Published private(set) var movie: DetailedMovie?
    
    var formattedRuntime: String {
        guard let runtime = movie?.runtime, runtime > 0 else { return "" }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: DateComponents(minute: movie?.runtime)) ?? ""
    }
    
    var contentRating: String {
        guard let releasesForUS = movie?.releaseDates?.results.filter({ $0.countryCode == "US"}).first,
              let theatricalRelease = releasesForUS.releaseDates.filter({ $0.type == ReleaseDateTypes.Theatrical.rawValue }).first
        else {
            return ""
        }
        
        return theatricalRelease.certification
    }
    
    var watchOptions: [CountryWatchOptions]? {
        guard let watchOptions = movie?.watchProviders?.results,
              !watchOptions.isEmpty else {
            return nil
        }
        
        let countries = ["CA", "US"]
        return movie?.watchProviders?.results
            .filter { countries.contains($0.key) }
            .map { CountryWatchOptions(countryCode: $0.key, watchOptions: $0.value) }
            .ordered(by: countries)
    }
    
    var mainVideos: [Video]? {
        return movie?.videos?.results.filtered(by: [.Trailer, .Teaser]).sortedByPriority()
    }
    
    var movieCast: [Credits.Cast] {
        Array(movie?.credits.cast.prefix(30) ?? [])
    }
    
    func castImageURL(from imagePath: String?) -> URL? {
        guard let imagePath else { return nil }
        return TMDBEndpoint(path: imagePath).imageURL(ofType: .profile)
    }
    
    @MainActor
    func getMovieDetails(for movieID: Int) async {
        do {
            movie = try await NetworkingManager.shared.getMovie(withId: movieID, including: [.releaseDates, .streamingProviders, .videos, .credits])
        } catch {
            print(error)
        }
    }
}
