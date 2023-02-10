//
//  SafariBrowserView.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-10.
//

import SwiftUI
import SafariServices

struct SafariBrowserView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

struct SafariBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        SafariBrowserView(url: URL(string: "https://apple.com")!)
    }
}
