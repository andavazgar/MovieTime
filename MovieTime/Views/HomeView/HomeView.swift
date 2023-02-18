//
//  HomeView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-16.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.movies) { movie in
                NavigationLink(
                    destination: { MovieDetailsView(movieID: movie.id) },
                    label: { MovieSearchResultView(movie: movie) }
                )
            }
            .listStyle(.grouped)
            .navigationTitle("Home")
            .searchable(text: $vm.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Find movies"))
            .overlay {
                if vm.searchTerm.isEmpty {
                    DiscoverView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
