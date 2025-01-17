//
//  DetailView.swift
//  cvsCoding
//
//  Created by Ashton Watson on 01/16/25.
//

import SwiftUI

struct DetailView: View {
    let photo: Photo

    @State private var isSharing: Bool = false
    @State private var shareItems: [Any] = []
    @State private var isLoading: Bool = false

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

                // Share Button
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: {
                        isLoading = true
                        createShareContent { items in
                            shareItems = items
                            isLoading = false
                            isSharing = true
                        }
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .font(.headline)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Details")
            .padding()
        }
        .sheet(isPresented: $isSharing) {
            if !shareItems.isEmpty {
                ActivityView(activityItems: shareItems)
            }
        }
    }

    private func createShareContent(completion: @escaping ([Any]) -> Void) {
        DispatchQueue.global().async {
            var items: [Any] = []
            if let imageURL = URL(string: photo.imageURL) {
                do {
                    let imageData = try Data(contentsOf: imageURL)
                    if let image = UIImage(data: imageData) {
                        items.append(image)
                    }
                } catch {
                    print("Error loading image: \(error)")
                }
            }
            items.append("Title: \(photo.title)\nAuthor: \(photo.author)\nTags: \(photo.tags)\nPublished: \(photo.formattedDate)")
            DispatchQueue.main.async {
                completion(items)
            }
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}




