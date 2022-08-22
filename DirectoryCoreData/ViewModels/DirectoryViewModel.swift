//
//  DirectoryViewModel.swift
//  DirectoryCoreData
//
//  Created by Colton Swapp on 8/22/22.
//

import SwiftUI
import CoreData

class DirectoryViewModel: ObservableObject {
    
    @Published var people: [Person] = []
    
    // Fetch request for retrieving data from our NSManagedObjectContext
    private lazy var fetchRequest: NSFetchRequest<Person> = {
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        return fetchRequest
    }()
    
    // Called from our .onAppear from the DirectoryHome view, to start the fetch
    func fetchAllPeople() {
        // If we have a list of people saved locally already, we will use that to populate our view.
        self.people = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        // If our fetch request returned no results, we go to the API to fetch our Directory
        if self.people.isEmpty {
            self.getDirectory()
        }
    }
    
    // Compact map over our individuals to convert them to CoreData entities.
    func convertDirectory(_ directory: Directory) {
        DispatchQueue.main.async {
            self.people = directory.individuals.compactMap { individual in
                let person = Person(id: individual.id, firstName: individual.firstName, lastName: individual.lastName, birthdate: individual.birthdate, profilePicture: individual.profilePicture, forceSensitive: individual.forceSensitive, affiliation: individual.getAffiliation())
                print("Person successfully converted to CoreData object")
                return person
            }
            CoreDataStack.saveChanges()
        }
        
    }
    
    func getDirectory() {
        // Use our network service to fetch the directory
        NetworkService.shared.fetch { result in
            switch result {
                
            case .success(let directory):
                // Loop through individuals and convert to CoreData objects
                self.convertDirectory(directory)
            case .failure(_):
                fatalError("The fetch was a failure.")
            }
        }
    }
    
}
