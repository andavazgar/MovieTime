//
//  ISO8601DateFormatter+Extensions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import Foundation

extension ISO8601DateFormatter {
    static let yearMonthDay: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        return formatter
    }()
    
    static let fullDateWithMilliseconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
