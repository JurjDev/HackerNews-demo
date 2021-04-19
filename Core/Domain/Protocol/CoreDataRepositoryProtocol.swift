//
//  CoreDataRepositoryProtocol.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation
import CoreData

protocol CoreDataRepositoryProtocol {
    
    associatedtype Entity
    
    func get(predicate: NSPredicate?, sortDesciptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    
    func create() -> Result<Entity, Error>
    func delete(entity: Entity) -> Result<Bool, Error>
}
