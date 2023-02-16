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
                
                VStack(alignment: .leading, spacing: 8) {
                    movieTitle
                    generalInfo
                    posterAndOverview
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
        AsyncImage(url: vm.backdropImageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            placeholderImage
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(placeholderImageColor)
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
        .padding(.bottom, 16)
        .offset(y: -6)
    }
    
    private var posterAndOverview: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: vm.posterImageURL) { image in
                image.resizable()
            } placeholder: {
                placeholderImage
            }
            .frame(width: 2/3 * 225, height: 225)
            .background(placeholderImageColor)
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
    
    private var placeholderImage: some View {
        Image(systemName: "photo")
            .renderingMode(.template)
            .foregroundColor(.black.opacity(0.7))
            .scaleEffect(1.5)
    }
    
    private let placeholderImageColor = Color.black.opacity(0.2)
    
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .padding(.top)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.shared.getMovie(withId: 0, including: [.streamingProviders])!
    
    static var previews: some View {
        MovieDetailsView(movieID: movie.id)
    }
}
