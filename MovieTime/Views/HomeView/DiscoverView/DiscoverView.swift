//
//  DiscoverView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-06.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject private var vm = DiscoverViewModel()
    @State private var hasFetchedData = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    list(of: vm.trendingMovies, withTitle: "Trending")
                    list(of: vm.nowPlayingMovies, withTitle: "Now Playing")
                    list(of: vm.upcomingMovies, withTitle: "Upcoming")
                }
                .padding()
            }
        }
        .task {
            if !hasFetchedData {
                await vm.getTrendingMovies()
                await vm.getNowPlayingMovies()
                await vm.getUpcomingMovies()
                hasFetchedData = true
            }
        }
    }
    
    private func list(of movies: [PartialMovie], withTitle title: String) -> some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetailsView(movieID: movie.id)
                        } label: {
                            MovieListRow(movie: movie)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 180)
                    }
                }
            }
        } header: {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
