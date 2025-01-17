//
//  ContentView.swift
//  cvsCoding
//
//  Created by Ashton Watson on 01/16/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                VStack {
                    TextField("Search", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                .background(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)

                Spacer()

                // Content
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if viewModel.photos.isEmpty {
                    Text("No results found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(viewModel.photos) { photo in
                                NavigationLink(destination: DetailView(photo: photo)) {
                                    URLImage(url: URL(string: photo.imageURL))
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
            }
            .navigationTitle("Flickr Search")
        }
    }
}


