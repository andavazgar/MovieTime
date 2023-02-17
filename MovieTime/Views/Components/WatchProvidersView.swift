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
        VStack {
            ForEach(watchOptions, id: \.countryCode) { country in
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(WatchOptionTypes.allCases, id: \.self) { watchOption in
                            if let providers = country.watchOptions.getProviders(for: watchOption) {
                                LazyHStack {
                                    Text(watchOption.rawValue)
                                        .frame(minWidth: 60, alignment: .leading)
                                    
                                    ForEach(providers) { provider in
                                        AsyncImage(url: TMDBEndpoint(path: provider.logoPath).imageURL(ofType: .logo)) { image in
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
                                .padding(.trailing)
                            }
                        }
                    }
                }
                .padding([.leading, .vertical])
                .padding(.top, 40)
                .background(.black.opacity(0.1))
                .cornerRadius(8)
                .overlay(alignment: .topLeading) {
                    HStack(spacing: 2) {
                        Text(country.flag)
                            .font(.largeTitle)
                        
                        Text(country.name)
                            .font(.headline.weight(.regular))
                    }
                    .padding(.top, 8)
                    .padding(.leading)
                    .offset(x: -2)
                }
            }
        }
    }
}

struct WatchProvidersView_Previews: PreviewProvider {
    static let movie = NetworkingManagerMock.shared.getMovie(withId: 0, including: [.streamingProviders])!
    
    static var previews: some View {
        MovieDetailsView(movieID: movie.id)
    }
}
