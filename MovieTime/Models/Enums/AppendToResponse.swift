//
//  AppendToResponse.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-08.
//

import Foundation

enum AppendToResponse: String {
    case images
    case releaseDates = "release_dates"
    case streamingProviders = "watch/providers"
    case videos
    
    static func buildQueryString(with values: [Self]?) -> String {
        values != nil ? "append_to_response=" + values!.map({ $0.rawValue }).joined(separator: ",") : ""
    }
}
