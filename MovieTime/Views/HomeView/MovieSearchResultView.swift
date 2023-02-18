//
//  MovieSearchResultView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-16.
//

import SwiftUI

struct MovieSearchResultView: View {
    let movie: PartialMovie
    var rowHeight = 150.0
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            posterImage
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.title3.bold())
                
                Text(movie.releaseYear)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                RatingsView(value: movie.rating)
            }
            .frame(maxWidth: .infinity, maxHeight: rowHeight, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: rowHeight, alignment: .leading)
    }
    
    
    // MARK: - Subviews
    private var posterImage: some View {
        AsyncImage(url: movie.posterImageURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            PlaceholderImageView(height: rowHeight, aspectRatio: 2/3)
        }
        .cornerRadius(8)
    }
}

struct MovieSearchResultView_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.shared.getTrendingMovies().first!
    
    static var previews: some View {
        MovieSearchResultView(movie: movie)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
