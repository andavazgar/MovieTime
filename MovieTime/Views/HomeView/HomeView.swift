//
//  HomeView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-16.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    
    init(vm: HomeViewModel = HomeViewModel()) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            List(vm.movies) { movie in
                MovieSearchResultView(movie: movie)
                    .background(NavigationLink("", destination: { MovieDetailsView(movieID: movie.id) }).opacity(0))
            }
            .listStyle(.grouped)
            .navigationTitle("Home")
            .searchable(text: $vm.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Find movies"))
            .overlay {
                if vm.searchTerm.isEmpty {
                    DiscoverView()
                        .background(Color(uiColor: UIColor.systemBackground))   // This prevents the background from being clear (transparent) and momentarily letting see the MovieSearchResultsView when the search is cancelled.
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDisplayName("DiscoverView")
        
        HomeView(vm: HomeViewModel(searchTerm: "Black Panther"))
            .previewDisplayName("Search screen")
    }
}
