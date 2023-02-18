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
                    trendingMovies
                }
                .padding()
            }
        }
        .task {
            if !hasFetchedData {
                await vm.getTrendingMovies()
                hasFetchedData = true
            }
        }
    }
    
    private var trendingMovies: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.movies) { movie in
                        NavigationLink {
                            MovieDetailsView(movieID: movie.id)
                        } label: {
                            MovieListRow(movie: movie)
                        }
                        .buttonStyle(.plain)

                    }
                }
            }
        } header: {
            Text("Trending")
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
