//
//  MovieTimeApp.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-06.
//

import SwiftUI

@main
struct MovieTimeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                WatchlistView()
                    .tabItem {
                        Label("Watchlist", systemImage: "bookmark.fill")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .environment(\.managedObjectContext, MovieTimeProvider.shared.viewContext)
        }
    }
}
