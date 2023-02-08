//
//  DateFormatter+Extensions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-07.
//

import Foundation

extension DateFormatter {
    static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        let date = inputDateFormatter.date(from: dateString)

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date!)
    }
}
