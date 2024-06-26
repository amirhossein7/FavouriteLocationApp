//
//  CoreDataService.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation
import CoreData



class CoreDataService: DatabaseProtocol {
    
    private let context = CoreDataManager.shared.persistentContainer.viewContext
    
    func getAllItems() -> [AnyObject] {
        let personFetch: NSFetchRequest<Person> = Person.fetchRequest()
        var persons: [Person] = []
        
        do {
            persons = try self.context.fetch(personFetch)
        }catch {
            Log("~ Error in fetching persons")
        }
        
        return persons
    }
    
    func getAllItemsAsPersonModel() -> [PersonModel] {
        var persons: [PersonModel] = []
        guard let items = getAllItems() as? [Person] else {return persons}
        items.forEach { item in
            guard let allAddresses = item.addresses?.allObjects as? [Address] else {
                Log("~ Error in casting NSSet to [Address]")
                return
            }
            let locations: [LocationModel] = {
                var locs: [LocationModel] = []
                allAddresses.forEach { addr in
                    let model = LocationModel(latitude: addr.latitude , longitude: addr.longitude)
                    locs.append(model)
                }
                return locs
            }()
            let person = PersonModel(id: item.objectID.hash ,firstName: item.firstName ?? "", lastName: item.lastName ?? "", locations: locations)
            persons.append(person)
        }
        return persons
    }
    
    func createPerson(firstName: String, lastName: String) {
        let person = Person(context: context)
        person.firstName = firstName
        person.lastName = lastName
        
        CoreDataManager.shared.saveContext()
    }
    
    func addLocation(personsID: [Int], latitude: Double, longitude: Double) {
        guard let persons = getAllItems() as? [Person] else {
            Log("~ error in add location")
            return
        }
        for id in personsID {
            for person in persons {
                if id == person.objectID.hash {
                    let address = Address(context: context)
                    address.person = person
                    address.latitude = latitude
                    address.longitude = longitude
                    CoreDataManager.shared.saveContext()
                }
            }
        }
        
    }
    
    func getPerson(model: PersonModel) throws -> PersonModel{
        do {
            let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "firstName == %@", model.firstName)
            let objects = try context.fetch(fetchRequest)
            let objc = objects.first { person in
                person.objectID.hash == model.id
            }
            guard let objc = objc else {
                throw NSError()
            }
            guard let locs = objc.addresses?.allObjects as? [Address] else {throw NSError()}
            let personLocs = locs.map { addr in
                LocationModel(latitude: addr.latitude , longitude: addr.longitude)
            }
            return PersonModel(id: objc.objectID.hash, firstName: objc.firstName ?? "", lastName: objc.lastName ?? "", locations: personLocs)

            
        }catch {
            Log("Error in getPerson: \(error.localizedDescription)")
            let error = NSError()
            throw error
        }
    }
    
    
    func deletePerson(model: PersonModel) {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "firstName == %@ AND lastName = %@", model.firstName, model.lastName)
            guard let objects = try context.fetch(fetchRequest) as? [Person] else { throw NSError()}
            let objc = objects.first { person in
                person.objectID.hash == model.id
            }
            guard let objc = objc else {
                throw NSError()
            }
          
            context.delete(objc)
            
            CoreDataManager.shared.saveContext()
            
        }catch {
            Log("Error in deletePerson")
        }
    }
}
