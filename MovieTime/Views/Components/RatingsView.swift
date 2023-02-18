//
//  RatingsView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-17.
//

import SwiftUI

struct RatingsView: View {
    let value: Double
    
    private var tint: Color {
        switch value {
        case 0..<4:
            return .red
        case 4..<7:
            return .orange
        default:
            return .green
        }
    }
    
    var body: some View {
        Gauge(value: value, in: 0...10) {
            Text(String(value))
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(tint)
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(value: 7)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
