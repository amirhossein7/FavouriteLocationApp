//
//  PeopleListViewModel.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation



class PeopleListViewModel {
    
    var database: DatabaseProtocol
    
    init() {
        database = CoreDataService()
    }
    
    func getAllItems() -> [CellViewModel]{
        var peoples: [CellViewModel] = []
        database.getAllItemsAsPersonModel().forEach { person in
            let model = CellViewModel(person: person)
            peoples.append(model)
        }
        return peoples
    }
    
    func createPerson(firstName: String, lastName: String) {
        database.createPerson(firstName: firstName, lastName: lastName)
    }
    
    func addAddress(personsID: [Int], lat: Double, long: Double) {
        database.addLocation(personsID: personsID, latitude: lat, longitude: long)
    }
}
