//
//  WatchlistView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-19.
//

import SwiftUI

struct WatchlistView: View {
    @FetchRequest(fetchRequest: WatchlistMovie.all(), animation: .easeInOut) private var movies
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetailsView(movieID: movie.id)
                        } label: {
                            MovieListRow(movie: movie, showMovieInfo: false)
                        }
                        .transition(.opacity)
                    }
                }
            }
            .navigationTitle("Watchlist")
            .padding()
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
