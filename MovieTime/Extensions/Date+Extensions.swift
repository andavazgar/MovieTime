//
//  Date+Extensions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-09.
//

import Foundation

extension Date {
    func component(_ dateComponent: Calendar.Component) -> Int {
        Calendar.current.component(dateComponent, from: self)
    }
}
