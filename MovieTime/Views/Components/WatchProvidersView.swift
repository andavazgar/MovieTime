//
//  WatchProvidersView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-11.
//

import SwiftUI

struct WatchProvidersView: View {
    let watchOptions: [CountryWatchOptions]
    
    var body: some View {
        ForEach(watchOptions, id: \.name) { country in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    Text(country.flag)
                        .scaleEffect(1.7)
                        .padding(.horizontal, 8)
                    
                    VStack(alignment: .leading) {
                        ForEach(WatchOptionTypes.allCases, id: \.self) { watchOption in
                            if let providers = country.watchOptions.getProviders(for: watchOption) {
                                LazyHStack {
                                    Text(watchOption.rawValue)
                                        .frame(minWidth: 60, alignment: .leading)
                                    
                                    ForEach(providers) { provider in
                                        AsyncImage(url: TMDBImage.imageURL(for: provider.logoPath, ofType: .logo)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            Circle()
                                                .fill(.black.opacity(0.3))
                                        }
                                        .clipShape(Circle())
                                    }
                                }
                                .frame(height: 60)
                            }
                        }
                    }
                }
            }
            .padding([.leading, .vertical])
            .background(.black.opacity(0.1))
            .cornerRadius(16)
        }
    }
}

struct WatchProvidersView_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.getMovie(withId: 0, including: [])!
    
    static var previews: some View {
        WatchProvidersView(watchOptions: movie.watchOptions ?? [])
    }
}
