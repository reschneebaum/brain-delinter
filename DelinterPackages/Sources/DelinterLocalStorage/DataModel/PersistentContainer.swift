//
//  File.swift
//  
//
//  Created by Rachel Schneebaum on 9/6/22.
//

import Foundation
import CoreData

class PersistentContainer: NSPersistentContainer {
    init() {
        guard let modelURL = Bundle.module.url(forResource: "DataModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Can't find object model")
        }
        super.init(name: "DataModel", managedObjectModel: model)
        
        configure()
    }
    
    private func configure() {
        loadPersistentStores { [weak self] description, error in
            if let error {
                fatalError("core data load error: \(error.localizedDescription)")
            }
            
            print("core data loaded: \(description)")
            
            // Overwrite the existing object's property values with those of the new object
            self?.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
