//
//  MovieDetailsView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieID: Int
    @StateObject private var vm = MovieDetailsViewModel()
    @State private var collapseOverview = true
    @State private var showVideo: Video?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                backdrop
                
                VStack(alignment: .leading, spacing: 16) {
                    movieTitle
                    generalInfo
                    posterAndOverview
                    
                    watchlistButton
                    
                    whereToWatch
                    videos
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .task {
            if vm.movie == nil {
                await vm.getMovieDetails(for: movieID)                
            }
        }
    }
    
    // MARK: - Subviews
    
    private var backdrop: some View {
        AsyncImage(url: vm.movie?.backdropImageURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            PlaceholderImageView(height: 200)
        }
    }
    
    private var movieTitle: some View {
        Text(vm.movie?.title ?? "")
            .font(.title.bold())
            .scaledToFit()
            .minimumScaleFactor(0.8)
    }
    
    private var generalInfo: some View {
        HStack(spacing: 10) {
            Text(vm.movie?.releaseYear ?? "")
            Text(vm.contentRating)
            Text(vm.formattedRuntime)
        }
        .foregroundColor(.secondary)
        .padding(.bottom, -4)
        .offset(y: -12)
    }
    
    @ViewBuilder
    private var posterAndOverview: some View {
        let posterSize = CGSize(width: 2/3 * 225.0, height: 225.0)
        
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: vm.movie?.posterImageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                PlaceholderImageView(width: posterSize.width, height: posterSize.height)
            }
            .frame(width: posterSize.width, height: posterSize.height)
            .cornerRadius(8)
            
            Text(vm.movie?.overview ?? "")
                .lineLimit(collapseOverview ? 10 : nil)
                .padding(.trailing)
                .transition(.move(edge: .bottom))
                .onTapGesture {
                    withAnimation {
                        collapseOverview.toggle()
                    }
                }
        }
    }
    
    @ViewBuilder
    private var watchlistButton: some View {
        if let movie = vm.movie {
            WatchlistButtonView(movie: movie, showAsIcon: false)
        }
    }
    
    @ViewBuilder
    private var whereToWatch: some View {
        if let watchOptions = vm.watchOptions {
            let sectionTitle = "Where To Watch"
            
            if watchOptions.count > 1 {
                CollapsibleSection(isCollapsed: true) {
                    sectionHeader("\(sectionTitle) (\(watchOptions.count))")
                } pinnedContent: {
                    WatchProvidersView(watchOptions: [watchOptions[0]])
                } collapsibleContent: {
                    WatchProvidersView(watchOptions: Array(watchOptions[1..<watchOptions.count]))
                }
            } else {
                CollapsibleSection(isCollapsed: false) {
                    sectionHeader(sectionTitle)
                } collapsibleContent: {
                    WatchProvidersView(watchOptions: watchOptions)
                }

            }
        }
    }
    
    @ViewBuilder
    private var videos: some View {
        if let videos = vm.mainVideos {
            Section {
                sectionHeader("Videos")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(videos) { video in
                            VideoView(thumbnailURL: video.thumbnailURL(), title: "\(video.type): \(video.name)")
                                .onTapGesture {
                                    showVideo = video
                                }
                        }
                    }
                }
                .sheet(item: $showVideo, content: { video in
                    if let videoURL = video.url(autoplay: true) {
                        SafariBrowserView(url: videoURL)
                    }
                })
            }
        }
    }
    
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.shared.getMovie(withId: 0, including: [.streamingProviders])!
    
    static var previews: some View {
        MovieDetailsView(movieID: movie.id)
    }
}
