//
//  PlaceholderImageView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-16.
//

import SwiftUI

struct PlaceholderImageView: View {
    var width: CGFloat? = nil
    var minWidth: CGFloat? = nil
    var idealWidth: CGFloat? = nil
    var maxWidth: CGFloat? = .infinity
    var height: CGFloat? = nil
    var minHeight: CGFloat? = nil
    var idealHeight: CGFloat? = nil
    var maxHeight: CGFloat? = .infinity
    var alignment: Alignment = .center
    var aspectRatio: CGFloat? = nil
    var contentMode: ContentMode = .fit
    
    var body: some View {
        Image(systemName: "photo")
            .renderingMode(.template)
            .foregroundColor(.black.opacity(0.7))
            .scaleEffect(1.5)
            .frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment)
            .frame(width: width, height: height, alignment: alignment)
            .aspectRatio(aspectRatio, contentMode: contentMode)
            .background(Color.black.opacity(0.2))
    }
}

struct PlaceholderImageView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImageView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
