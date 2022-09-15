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
    
    func getAllItems() -> [PeopleCellModel]{
        var peoples: [PeopleCellModel] = []
        database.getAllItemsAsPersonModel().forEach { person in
            let model = PeopleCellModel(person: person)
            peoples.append(model)
        }
        return peoples
    }
    
    func createPerson(firstName: String, sureName: String) {
        database.createPerson(firstName: firstName, sureName: sureName)
    }
    
    func addAddress(person: Person, lat: Double, long: Double) {
        database.addLocation(person: person, latitude: lat, longitude: long)
    }
}
