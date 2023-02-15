//
//  PartialMoviesResponse.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

struct PartialMoviesResponse: Codable {
    let page: Int
    let results: [PartialMovie]
    let totalPages: Int
    let totalResults: Int
}
