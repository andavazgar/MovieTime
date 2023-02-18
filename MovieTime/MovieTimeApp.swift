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
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                EmptyView()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Watchlist")
                    }
            }
        }
    }
}
