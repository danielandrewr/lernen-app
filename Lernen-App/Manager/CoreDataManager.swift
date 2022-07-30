//
//  CoreDataManager.swift
//  Lernen-App
//
//  Created by Daniel Roong on 30/07/22.
//

import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Lernen-App")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print(error.localizedDescription)
                print("Lernen <<DEV>>: Failed to load persistent container!")
            } else {
                print("Lernen <<DEV>>: Persistent container successfully loaded!")
            }
        }
    }
}
