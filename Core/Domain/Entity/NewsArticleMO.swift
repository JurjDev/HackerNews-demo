//
//  NewsArticleMO.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

protocol DomainModel {
    associatedtype DomainModelType
    
    func toDomainModel() -> DomainModelType
}

extension NewsArticleMO: DomainModel {
    
    public func toDomainModel() -> NewsEntity {
        return NewsEntity(
            author: author!,
            createdAt: Int(createdAt),
            objectID: String(id),
            title: title!,
            url: url,
            visible: visible
        )
    }
}
