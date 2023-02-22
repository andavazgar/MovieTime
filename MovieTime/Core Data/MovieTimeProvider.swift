//
//  MovieTimeProvider.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-19.
//

import Foundation
import CoreData
import SwiftUI

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
        if EnvironmentValues.isPreview {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}


// MARK: - Extension for Preview
extension EnvironmentValues {
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
