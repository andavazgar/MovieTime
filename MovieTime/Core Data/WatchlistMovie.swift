//
//  WatchlistMovie.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-19.
//
//

import Foundation
import CoreData


final class WatchlistMovie: NSManagedObject, Movie {
    @NSManaged var movieID: Int64
    @NSManaged var title: String
    @NSManaged var originalTitle: String
    @NSManaged var overview: String
    @NSManaged var originalLanguage: String
    @NSManaged var releaseDate: Date?
    @NSManaged var voteAverage: Double
    @NSManaged var countOfVotes: Int64
    @NSManaged var adult: Bool
    @NSManaged var posterPath: String?
    @NSManaged var backdropPath: String?
    @NSManaged var dateAdded: Date
    
    var id: Int {
        get { Int(movieID) }
        set { movieID = Int64(newValue) }
    }
    
    var voteCount: Int {
        get { Int(countOfVotes) }
        set { countOfVotes = Int64(newValue) }
    }
    
    @discardableResult
    init<M: Movie>(context: NSManagedObjectContext, movie: M) {
        let entity = NSEntityDescription.entity(forEntityName: "WatchlistMovie", in: context)!
        super.init(entity: entity, insertInto: context)
        
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.adult = movie.adult
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.dateAdded = Date()
    }
    
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}


// MARK: - FetchRequests
extension WatchlistMovie {
    private static var watchlistMoviesFetchRequest: NSFetchRequest<WatchlistMovie> {
        NSFetchRequest(entityName: "WatchlistMovie")
    }
    
    static func all() -> NSFetchRequest<WatchlistMovie> {
        let request = watchlistMoviesFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \WatchlistMovie.dateAdded, ascending: false)
        ]
        return request
    }
    
    static func findMovie(withID id: Int) -> NSFetchRequest<WatchlistMovie> {
        let request = watchlistMoviesFetchRequest
        request.predicate = NSPredicate(format: "movieID == %ld", id)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \WatchlistMovie.movieID, ascending: true)
        ]
        request.fetchLimit = 1
        
        return request
    }
}


extension WatchlistMovie {
    static func toggleWatchlistStatus<M: Movie>(for movie: M) {
        let context = MovieTimeProvider.shared.viewContext
        let request = Self.findMovie(withID: movie.id)
        
        if let movie = try? context.fetch(request).first {
            context.delete(movie)
        } else {
            WatchlistMovie(context: context, movie: movie)
        }
        
        // Save changes
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}


extension WatchlistMovie {
    private static let trendingMovies = NetworkingManagerMock.shared.getTrendingMovies()
    
    @discardableResult
    static func makePreview(count: Int = trendingMovies.count, in context: NSManagedObjectContext) -> [WatchlistMovie] {
        var movies = [WatchlistMovie]()
        
        for i in 0..<min(trendingMovies.count, abs(count)) {
            movies.append(WatchlistMovie(context: context, movie: trendingMovies[i]))
        }
        return movies
    }
    
    static func preview(context: NSManagedObjectContext = MovieTimeProvider.shared.viewContext) -> WatchlistMovie {
        makePreview(count: 1, in: context)[0]
    }
}
