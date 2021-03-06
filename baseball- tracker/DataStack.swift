//
//  TeamStack.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import CoreData

func createDataContainer(completion: @escaping (NSPersistentContainer) -> Void) {
    let container = NSPersistentContainer(name: "baseball__tracker")
    container.loadPersistentStores { (_, error) in
        guard error == nil else { fatalError("Failed to load store: \(error?.localizedDescription as Any)")}
        DispatchQueue.main.async {
            completion(container)
        }
    }
}
