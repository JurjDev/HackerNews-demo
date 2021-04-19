//
//  NewsCDService.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation
import CoreData

final public class NewsCDService {
    
    private let context: NSManagedObjectContext
    
    public let newsCDRepository: NewsCDRepository
    
    public init(context: NSManagedObjectContext) {
        self.context = context
        self.newsCDRepository = NewsCDRepository(context: context)
    }
    
    @discardableResult
    public func saveChanges() -> Result<Bool, Error> {
        
        do {
            if context.hasChanges {
                try context.save()
            }
            return .success(true)
            
        } catch {
            context.rollback()
            return .failure(error)
        }
    }
}
