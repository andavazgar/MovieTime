//
//  AppendedResults.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import Foundation

struct AppendedResults<T: Codable>: Codable {
    let results: T
}
