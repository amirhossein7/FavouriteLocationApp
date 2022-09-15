//
//  CoreDataService.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation
import CoreData



class CoreDataService: DatabaseProtocol {
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
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
            let person = PersonModel(id: item.objectID.hash ,firstName: item.firstName ?? "", sureName: item.sureName ?? "", locations: locations)
            persons.append(person)
        }
        return persons
    }
    
    func createPerson(firstName: String, sureName: String) {
        let person = Person(context: context)
        person.firstName = firstName
        person.sureName = sureName
        
        CoreDataManager.shared.saveContext()
    }
    
    func addLocation(person: AnyObject, latitude: Double, longitude: Double) {
        let address = Address(context: context)
        address.person = (person as! Person)
        address.latitude = latitude
        address.longitude = longitude
        
        CoreDataManager.shared.saveContext()
    }
    
    
}
