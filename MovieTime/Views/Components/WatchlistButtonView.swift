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
    var isInList: Bool
    
    init(movie: M, showAsIcon: Bool = true, isInList: Bool = false) {
        self._movieInWatchlist = FetchRequest(fetchRequest: WatchlistMovie.findMovie(withID: movie.id))
        self.movie = movie
        self.showAsIcon = showAsIcon
        self.isInList = isInList
    }
    
    var body: some View {
        Button {
            if !isInList {
                toggleWatchlistStatus()
            }
        } label: {
            watchlistIconLabel
        }
        .conditionalButtonStyle(condition: showAsIcon, true: .automatic, false: .bordered)
        .tint(.yellow)
        .fontWeight(.bold)
        .onTapGesture {
            if isInList {
                toggleWatchlistStatus()
            }
        }
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
    
    private func toggleWatchlistStatus() {
        WatchlistMovie.toggleWatchlistStatus(for: movie)
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
