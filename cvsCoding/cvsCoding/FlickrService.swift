//
//  FlickrService.swift
//  cvsCoding
//
//  Created by Ashton Watson on 01/16/25.
//

import Foundation

class FlickrService {
    func fetchPhotos(query: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let feed = try JSONDecoder().decode(FlickrFeed.self, from: data)
                completion(.success(feed.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
