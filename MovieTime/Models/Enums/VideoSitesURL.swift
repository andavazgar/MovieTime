//
//  VideoSitesURL.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-10.
//

import Foundation

enum VideoSitesURL {
    case YouTube(videoID: String)
    
    func url(autoplay: Bool = false) -> URL? {
        switch self {
        case .YouTube(let videoID):
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "youtube.com"
            urlComponents.path = "/embed/" + videoID
            urlComponents.queryItems = [
                URLQueryItem(name: "rel", value: "0"),  // At the end of the video only shows other videos from the same YouTube channel. This helps avoid spoilers.
                URLQueryItem(name: "autoplay", value: autoplay ? "1" : "0")
            ]
            
            return urlComponents.url
        }
    }
    
    func thumbnail() -> URL? {
        switch self {
        case .YouTube(let videoID):
            return URL(string: "https://img.youtube.com/vi/\(videoID)/mqdefault.jpg")
        }
    }
}
