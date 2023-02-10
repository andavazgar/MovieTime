//
//  MovieDetails.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import SwiftUI

struct MovieDetails: View {
    let movie: Movie
    
    @State private var showVideo: Video?
    
    init(for movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                backdrop
                
                VStack(alignment: .leading, spacing: 8) {
                    movieTitle
                    generalInfo
                    posterAndOverview
                    videos
                }
                .padding()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var backdrop: some View {
        Rectangle()
            .frame(height: 200)
    }
    
    private var movieTitle: some View {
        Text(movie.title)
            .font(.title.bold())
            .scaledToFit()
            .minimumScaleFactor(0.8)
    }
    
    private var generalInfo: some View {
        HStack(spacing: 10) {
            Text(String(movie.releaseDate.component(.year)))
            Text(movie.contentRating)
            Text(movie.formattedRuntime)
        }
        .foregroundColor(.secondary)
        .padding(.bottom, 16)
        .offset(y: -6)
    }
    
    private var posterAndOverview: some View {
        HStack(spacing: 16) {
            Rectangle()
                .aspectRatio(2/3, contentMode: .fit)
            
            Text(movie.overview)
                .lineLimit(10)
                .padding(.trailing)
        }
        .frame(height: 225)
    }
    
    @ViewBuilder
    private var videos: some View {
        if let videos = movie.mainVideos {
            Section {
                Text("Videos")
                    .font(.title2)
                    .padding(.top)
                
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
}

struct MovieDetails_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.getMovie(withId: 0, including: [.streamingProviders])!
    
    static var previews: some View {
        MovieDetails(for: movie)
    }
}
