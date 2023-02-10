//
//  JSONDecoder+Extensions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import Foundation

extension JSONDecoder {
    var dateDecodingStrategyFormatters: [ISO8601DateFormatter] {
        get { return [] }
        set {
            let formatters = newValue
            
            self.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                for formatter in formatters {
                    if let date = formatter.date(from: dateString) {
                        return date
                    }
                }
                
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            }
        }
    }
}
