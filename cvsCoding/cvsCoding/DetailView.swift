//
//  DetailView.swift
//  cvsCoding
//
//  Created by Ashton Watson on 11/20/24.
//

import SwiftUI

struct DetailView: View {
    let photo: Photo

    var body: some View {
        ScrollView {
            VStack {
                URLImage(url: URL(string: photo.imageURL))
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: 250)
                    .cornerRadius(10)
                    .padding()

                Text(photo.title)
                    .font(.headline)
                    .padding(.top)

                Text("Author: \(photo.author)")
                    .font(.subheadline)
                    .padding(.top)

                Text(photo.tags)
                    .padding()

                Text("Published: \(photo.formattedDate)")
                    .font(.caption)
                    .padding()

                Spacer()
            }
            .navigationTitle("Details")
            .padding()
        }
    }
}

