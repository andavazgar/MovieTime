//
//  WatchOptions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-10.
//

import Foundation

struct WatchOptions: Codable {
    let link: URL?
    let free: [StreamingProvider]?
    let ads: [StreamingProvider]?
    let flatrate: [StreamingProvider]?
    let rent: [StreamingProvider]?
    let buy: [StreamingProvider]?
    
    func getProviders(for type: WatchOptionTypes) -> [StreamingProvider]? {
        switch type {
        case .free:
            return self.free
        case .ads:
            return self.ads
        case .flatrate:
            return self.flatrate
        case .rent:
            return self.rent
        case .buy:
            return self.buy
        default:
            return nil
        }
    }
}
