//
//  URLImage.swift
//  cvsCoding
//
//  Created by Ashton Watson on 01/16/25.
//

import SwiftUI

struct URLImage: View {
    let url: URL?
    @State private var image: UIImage? = nil

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            ProgressView()
                .onAppear(perform: loadImage)
        }
    }

    private func loadImage() {
        guard let url = url else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
    }
}
