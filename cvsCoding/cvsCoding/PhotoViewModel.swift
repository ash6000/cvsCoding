//
//  PhotoViewModel.swift
//  cvsCoding
//
//  Created by Ashton Watson on 01/16/25.
//

import SwiftUI
import Combine

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet {
            fetchPhotos()
        }
    }

    private let service = FlickrService()

    func fetchPhotos() {
        guard !searchText.isEmpty else {
            photos = []
            return
        }

        isLoading = true
        service.fetchPhotos(query: searchText.replacingOccurrences(of: " ", with: ",")) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let photos):
                    self?.photos = photos
                case .failure(let error):
                    print("Error fetching photos: \(error)")
                    self?.photos = []
                }
            }
        }
    }
}

