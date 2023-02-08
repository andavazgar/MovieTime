//
//  MovieListView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-06.
//

import SwiftUI

struct MovieListView: View {
    @State private var movies = [Movie]()
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(movies) { movie in
                        MovieListRow(movie: movie)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            movies = NetworkingManagerMock.getTrendingMovies()
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
