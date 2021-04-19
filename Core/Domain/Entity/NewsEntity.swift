//
//  NewsEntity.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public struct NewsEntity {
    
    public let author: String

    public let createdAt: Int

    public let objectID: String

    public let title: String

    public let url: String?
    
    public var visible: Bool
    
    public init(author: String,
                createdAt: Int,
                objectID: String,
                title: String,
                url: String?,
                visible: Bool) {
        
        self.author = author
        self.createdAt = createdAt
        self.objectID = objectID
        self.title = title
        self.url = url
        self.visible = visible
    }
}
