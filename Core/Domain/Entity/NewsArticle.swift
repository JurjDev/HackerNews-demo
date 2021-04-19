//
//  NewsArticle.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public struct NewsArticle: Equatable, Hashable, Codable {
    
    public let author: String

    public let createdAt: Int

    public let objectID: String

    public let title: String?

    public let storyTitle: String?

    public let storyUrl: String?

    public let url: String?

    internal enum CodingKeys: String, CodingKey {

        case author
        case createdAt = "created_at_i"
        case objectID
        case title
        case storyTitle = "story_title"
        case storyUrl = "story_url"
        case url
    }
}

extension NewsArticle: DomainModel {
    
    public func toDomainModel() -> NewsEntity {
        return NewsEntity(
            author: author,
            createdAt: Int(createdAt),
            objectID: objectID,
            title: title ?? storyTitle ?? "No Title",
            url: url ?? storyUrl,
            visible: true
        )
    }
}
