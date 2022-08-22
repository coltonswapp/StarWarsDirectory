//
//  CoreDataStack.swift
//  DirectoryCoreData
//
//  Created by Colton Swapp on 8/21/22.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DirectoryCoreData")
        container.loadPersistentStores { _ , error in
            if let error = error {
                fatalError("Failed to load Persistent Store")
            }
        }
        
        return container
    }()
    
    static var context : NSManagedObjectContext { container.viewContext }
    
    static func saveChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context. \(error.localizedDescription)")
            }
        }
    }
}

extension Person {
    
    @discardableResult
    convenience init(id: Int, firstName: String, lastName: String, birthdate: String, profilePicture: String, forceSensitive: Bool, affiliation: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = Int32(id)
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.profilePicture = profilePicture
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
    }
}
