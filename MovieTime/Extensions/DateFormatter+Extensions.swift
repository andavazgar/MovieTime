//
//  DateFormatter+Extensions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

extension DateFormatter {
    static let monthDayYear: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter
    }()
}
