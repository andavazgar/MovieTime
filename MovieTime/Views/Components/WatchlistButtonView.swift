//
//  WatchlistButtonView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-18.
//

import SwiftUI

struct WatchlistButtonView<M: Movie>: View {
    @FetchRequest private var movieInWatchlist: FetchedResults<WatchlistMovie>
    private var isInWatchlist: Bool {
        movieInWatchlist.first != nil
    }
    
    let movie: M
    var showAsIcon: Bool
    
    init(movie: M, showAsIcon: Bool = true) {
        self._movieInWatchlist = FetchRequest(fetchRequest: WatchlistMovie.findMovie(withID: movie.id))
        self.movie = movie
        self.showAsIcon = showAsIcon
    }
    
    var body: some View {
        Button {
            WatchlistMovie.toggleWatchlistStatus(for: movie)
        } label: {
            watchlistIconLabel
        }
        .conditionalButtonStyle(condition: showAsIcon, true: .automatic, false: .bordered)
        .tint(.yellow)
        .fontWeight(.bold)
    }
    
    @ViewBuilder
    private var watchlistIconLabel: some View {
        let watchlistIcon = Image(systemName: isInWatchlist ? "bookmark.fill" : "bookmark")
        
        if showAsIcon {
            watchlistIcon
                .font(.title2)
        } else {
            Label {
                Text(isInWatchlist ? "Remove from Watchlist" : "Add to Watchlist")
            } icon: {
                watchlistIcon
            }
        }
    }
}

struct WatchlistButtonView_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.shared.getTrendingMovies()[0]
    
    static var previews: some View {
        VStack(spacing: 16) {
            WatchlistButtonView(movie: movie)
            WatchlistButtonView(movie: movie, showAsIcon: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}


// MARK: - Extensions
extension Button {
    @ViewBuilder
    func conditionalButtonStyle<T: PrimitiveButtonStyle, S: PrimitiveButtonStyle>(condition: Bool, true trueStyle: T, false falseStyle: S) -> some View {
        if condition {
            self.buttonStyle(trueStyle)
        } else {
            self.buttonStyle(falseStyle)
        }
    }
}
