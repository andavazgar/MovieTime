//
//  MovieTimeProvider.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-19.
//

import Foundation
import CoreData

final class MovieTimeProvider {
    static let shared = MovieTimeProvider()
    private let container = NSPersistentContainer(name: "MovieTimeDataModel")
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    private init() {
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}
