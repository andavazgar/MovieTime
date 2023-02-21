//
//  VideoView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-10.
//

import SwiftUI

struct VideoView: View {
    var thumbnailURL: URL?
    var title: String?
    var aspectRatio: Double = 16/9
    var height: Double = 100
    var width: Double {
        height * aspectRatio
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: thumbnailURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .fill(.black.opacity(0.9))
            }
            .aspectRatio(aspectRatio, contentMode: .fit)
            .frame(height: height)
            .cornerRadius(8)
            .overlay {
                Image(systemName: "play.circle.fill")
                    .foregroundColor(.white.opacity(0.7))
                    .scaleEffect(3)
                    .shadow(radius: 3)
            }
            
            if let title {
                Text(title)
                    .multilineTextAlignment(.center)
                    .lineLimit(2, reservesSpace: true)
            }
        }
        .frame(width: width, alignment: .top)
    }
}

struct VideoView_Previews: PreviewProvider {
    static let thumbnailURL = VideoSitesURL.YouTube(videoID: "_Z3QKkl1WyM").thumbnail()
    static var previews: some View {
        VideoView()
    }
}
