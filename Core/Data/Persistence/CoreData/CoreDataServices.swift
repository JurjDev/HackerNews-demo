//
//  CoreDataServices.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation
import CoreData

final public class CoreDataServices {
    
    public static let shared = CoreDataServices()
    
    let identifier: String = "com.jurjdev.Core"
    
    let model: String = "HackerNews"
    
    public lazy var persistendContainer: NSPersistentContainer = {
       
        let bundle = Bundle(identifier: self.identifier)
        let url = bundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: url)
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error" + error.localizedDescription)
            }
        }
        return container
    }()
}
