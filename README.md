# MovieTime

MovieTime is an app that uses [The Movie Database API (TMDB)](https://developers.themoviedb.org/3) to allow users to keep track of the movies they want to watch (Watchlist) and where they can watch them (Streaming services). Also, MovieTime presents many lists of movies (Trending, Now Playing and Upcoming) to help the user build up their list of movies to watch.

## Technologies
- SwiftUI
- MVVM Architecture
- Networking
	- `URLSession` with Swift Concurrency
	- `Codable` with `JSONDecoder`
- Combine
	- Used in the HomeView to query the API while the user is searching for a movie. I used `.debouce()` to wait 0.5 seconds before performing a request. This avoids unnecessary network calls.
- Core Data
	- Used to persist the Watchlist of movies
	- Used `NSPredicate` and `NSSortDescriptor` to filter and sort the results
- `UserDefaults` (for Settings storage)
	- Used to persists the countries to show in the "Where to Watch" section of the `MovieDetailsView` screen
	- `JSONEncoder` and `JSONDecoder` were used to store the settings as `Data` objects
- UIKit
	- Used the `UIViewControllerRepresentable` protocol to manage a `SFSafariViewController` and present the trailer videos without leaving the app


## Screens

### HomeView
`HomeView` presents a search bar to find movies to add to the watchlist. While the search bar is empty, the `DiscoverView` is overlaid on top.

#### DiscoverView
`DiscoverView` is a screen that presents multiple lists of movies to help the user find movies to add to their Watchlist. At the moment, the list of movies shown are: _Trending_, _Now Playing_ and _Upcoming_.

### WatchlistView
`WatchlistView` presents a grid of movies that the user has added to their Watchlist. The movies are persisted using `Core Data`.

### MovieDetailsView
`MovieDetailsView` presents all the information related to a movie. It shows a cover and poster photos, overview of the movie, where to watch it, trailer and teaser videos as well as the cast (actors) that appear in it.

### SettingsView
`SettingsView` shows a list of all the countries for which there is where to watch information (Streaming services and/or stores). The user can select which countries they want to see in the "Where to Watch" section of the `MovieDetailsView` screen. Their list of selected countries is persisted in `UserDefaults`.


## What I learned / Gained more experience in
- Swift Concurrency
	- I learned how to perform API call using `async/await`
	- Learned about `Task` and `.task()` ViewModifier to perform asynchronous tasks.
	- Learned about actors, more specifically `@MainActor` to perform UI changes on the main thread.
- Combine
	- I learned about `.sink()` and `.debouse()` to perform API calls effectively instead of performing a fetch request after every change of the search query.
- Core Data
	- I learned how to use `Core Data` to persist the list of watchlist movies.
- How to structure API URLs (Endpoints)
	- I learned to create an `Endpoint` struct to build the API URLs using `URLComponents` instead of having many URLs scattered throughout the project.
- SwiftUI
	- I learned about `PreferenceKey` to send data from a child view to a parent view. I needed this because I created a collapsible view. I needed to get the minimum height and the maximum height of the child view to be able to change the height of the parent view between the two values.


## Difficulties
- Core data
	- Problem: I unticked the Optional option in the `.xcdatamodel` because the properties weren't optional. However, when saving the context I keep receiving errors: `"Multiple validation errors occurred."` mentioning that the values were required but were nil even though they weren't.
	- To solve this problem I had to make the properties optional again in the `.xcdatamodel` file.  
	However, to make sure that they could never be nil, I created an initializer that takes the context and the Movie object that was fetched from the API. In this custom initializer I populated all the properties that I wanted to persist. This solution prevented the possibility of having nil values as well as made the creation of `NSManaged` objects easy since I didn't have to populate the properties manually each time.
