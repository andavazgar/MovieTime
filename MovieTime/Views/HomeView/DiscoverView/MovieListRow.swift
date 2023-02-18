//
//  MovieListRow.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import SwiftUI

struct MovieListRow: View {
    let movie: any Movie
    private let cornerRadius = 25.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            posterImage
                .overlay(alignment: .bottomTrailing) {
                    rating
                }
            
            movieInfo
        }
        .frame(width: 180)
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
                    .scaledToFit()
            } placeholder: {
                PlaceholderImageView(aspectRatio: 2/3)
            }
            .cornerRadius(cornerRadius)
    }
    
    private var rating: some View {
        RatingsView(value: movie.rating)
            .background(Circle().fill(.black))
            .foregroundColor(.white)
            .offset(x: -7, y: -7)
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
            .padding(20)
            .previewLayout(.sizeThatFits)
    }
}
