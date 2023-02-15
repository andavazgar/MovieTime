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
        .frame(width: 200)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.gray.opacity(0.1))
                .shadow(radius: 2, x: 0, y: 2)
        )
    }
    
    private var posterImage: some View {
        AsyncImage(url: TMDBEndpoint(path: movie.posterPath).imageURL(ofType: .poster)) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
            }
            .cornerRadius(cornerRadius)
            .aspectRatio(2/3, contentMode: .fit)
    }
    
    private var rating: some View {
        ZStack {
            Circle()
                .foregroundColor(.black.opacity(0.7))
                .frame(width: 50)
            
            Text(movie.rating)
                .foregroundColor(Color(uiColor: UIColor.systemBackground))
                .shadow(color: .primary, radius: 1, x: 1, y: 1)
        }
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
