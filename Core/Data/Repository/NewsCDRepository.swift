//
//  NewsCDRepository.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation
import CoreData

public protocol NewsCDRepositoryProtocol {
    
    func getNews(predicate: NSPredicate?) -> Result<[NewsEntity], Error>
    
    func create(news: NewsEntity) -> Result<Bool, Error>
    
    func createUnique(news: NewsEntity) -> Result<Bool, Error>
    
    func updateState(state: Bool, predicate: NSPredicate?) -> Result<Bool, Error>
}

public class NewsCDRepository: NewsCDRepositoryProtocol {
    
    private let repository: CoreDataRepository<NewsArticleMO>
    
    public init(context: NSManagedObjectContext) {
        
        self.repository = CoreDataRepository<NewsArticleMO>(managedObjectContext: context)
    }
    
    @discardableResult
    public func getNews(predicate: NSPredicate?) -> Result<[NewsEntity], Error> {
        let result = repository.get(predicate: predicate, sortDesciptors: nil)
        switch result {
        case let .success(newsMO):
            let news = newsMO.map { $0.toDomainModel() }
            return .success(news)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    @discardableResult
    public func create(news: NewsEntity) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case let .success(newsMO):
            newsMO.id = Int64(news.objectID)!
            newsMO.author = news.author
            newsMO.createdAt = Int64(news.createdAt)
            newsMO.title = news.title
            newsMO.url = news.url
            newsMO.visible = true
            return .success(true)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    @discardableResult
    public func createUnique(news: NewsEntity) -> Result<Bool, Error> {
        let predicate = NSPredicate(format: "id == %@", news.objectID)
        if let result = repository.create(with: predicate) {
            switch result {
            case let .success(newsMO):
                newsMO.id = Int64(news.objectID)!
                newsMO.author = news.author
                newsMO.createdAt = Int64(news.createdAt)
                newsMO.title = news.title
                newsMO.url = news.url
                newsMO.visible = true
                return .success(true)
            case let .failure(error):
                return .failure(error)
            }
        } else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
    }
    
    public func updateState(state: Bool, predicate: NSPredicate?) -> Result<Bool, Error> {
        let result = repository.get(predicate: predicate, sortDesciptors: nil)
        switch result {
        case let .success(newsMO):
            let first = newsMO.first!
            first.visible = state
            return .success(true)
        case let .failure(error):
            return .failure(error)
        }
    }
}
