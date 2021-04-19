//
//  HackNews.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public struct HackNews: Equatable, Hashable, Codable {
    
    public let newsArticle: [NewsArticle]
    
    internal enum CodingKeys: String, CodingKey {
        
        case newsArticle = "hits"
    }
}
