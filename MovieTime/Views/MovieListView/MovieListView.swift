//
//  MovieListView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-06.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var vm = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(vm.movies) { movie in
                        NavigationLink {
                            MovieDetailsView(movieID: movie.id)
                        } label: {
                            MovieListRow(movie: movie)
                        }
                        .buttonStyle(.plain)

                    }
                }
                .padding()
            }
        }
        .task {
            await vm.getTrendingMovies()
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
