//
//  MovieListRow.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import SwiftUI

struct MovieListRow<M: Movie>: View {
    let movie: M
    var showMovieInfo = true
    private let cornerRadius = 16.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            posterImage
                .overlay(alignment: .topTrailing) {
                    watchlistButton
                }
                .overlay(alignment: .bottomTrailing) {
                    if movie.rating > 0 {
                        rating                        
                    }
                }
            
            if showMovieInfo {
                movieInfo
            }
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.gray.opacity(0.1))
                .shadow(radius: 2, x: 0, y: 2)
        )
    }
    
    private var posterImage: some View {
        AsyncImage(url: movie.posterImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fit)
            } placeholder: {
                PlaceholderImageView(aspectRatio: 2/3)
            }
            .cornerRadius(cornerRadius)
    }
    
    private var watchlistButton: some View {
        WatchlistButtonView(movie: movie)
            .padding(8)
            .background(.regularMaterial, in: Circle())
            .environment(\.colorScheme, .dark)
            .offset(x: -6, y: 4)
            .shadow(radius: 1)
    }
    
    private var rating: some View {
        RatingsView(value: movie.rating)
            .background(.regularMaterial, in: Circle())
            .environment(\.colorScheme, .dark)
            .foregroundColor(.white)
            .scaleEffect(0.8)
            .offset(x: -2, y: -2)
    }
    
    private var movieInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(movie.title)
                .font(.title3.bold())
                .lineLimit(2, reservesSpace: true)
            
            Text(movie.formattedReleaseDate)
                .foregroundColor(.secondary)
        }
        .padding(12)
    }
}

struct MovieListRow_Previews: PreviewProvider {
    static let movies = NetworkingManagerMock.shared.getTrendingMovies()
    
    static var previews: some View {
        MovieListRow(movie: movies[0])
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
