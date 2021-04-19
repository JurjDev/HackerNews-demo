//
//  CoreDataRepository.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case invalidManagedObjectType
    
    case duplicateManagedObjectType
}

final class CoreDataRepository<T: NSManagedObject>: CoreDataRepositoryProtocol {
    
    typealias Entity = T
    
   private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        
        self.managedObjectContext = managedObjectContext
    }
    
    func get(predicate: NSPredicate?, sortDesciptors: [NSSortDescriptor]?) -> Result<[Entity], Error> {
        
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDesciptors
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return.failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func create() -> Result<T, Error> {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        return .success(managedObject)
    }
    
    func create(with predicate: NSPredicate) -> (Result<T, Error>)? {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                if fetchResults.count > 0 {
                    return .failure(CoreDataError.duplicateManagedObjectType)
                } else {
                    return create()
                }
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func delete(entity: T) -> Result<Bool, Error> {
        managedObjectContext.delete(entity)
        return .success(true)
    }
}
