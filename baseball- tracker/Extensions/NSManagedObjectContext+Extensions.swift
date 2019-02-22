//
//  NSManagedObjectContext+Extensions.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    func performChanges(block: @escaping () -> Void) {
        perform {
            _ = self.saveOrRollback()
        }
    }
}
