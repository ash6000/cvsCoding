//
//  Photo.swift
//  cvsCoding
//
//  Created by Ashton Watson on 01/16/25.
//

import Foundation

struct Photo: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let tags: String
    let author: String
    let imageURL: String
    let published: String

    private enum CodingKeys: String, CodingKey {
        case title
        case tags
        case author
        case media
        case published
    }

    private enum MediaKeys: String, CodingKey {
        case m
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        tags = try container.decode(String.self, forKey: .tags)
        author = try container.decode(String.self, forKey: .author)
        published = try container.decode(String.self, forKey: .published)
        
        let mediaContainer = try container.nestedContainer(keyedBy: MediaKeys.self, forKey: .media)
        imageURL = try mediaContainer.decode(String.self, forKey: .m)
    }

    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        
        if let date = formatter.date(from: published) {
            return displayFormatter.string(from: date)
        }
        return "N/A"
    }
}
