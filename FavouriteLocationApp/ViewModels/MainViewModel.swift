//
//  MainViewModel.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation
import CoreLocation

class MainViewModel {
        
    var database: DatabaseProtocol
    
    private var peopleArray: [CellViewModel] = []
    var chosenLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    var numberOfCells: Int {
        return peopleArray.count
    }
    
    var selectedPeople: [CellViewModel] {
        return peopleArray.filter {$0.isSelected}
    }
    
    init() {
        database = CoreDataService()
    }
    
    
    func selectPeople(at indexPath: IndexPath) {
        peopleArray[indexPath.row].select()
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CellViewModel {
        return peopleArray[indexPath.row]
    }
    

    func reloadData(completion: () -> ()) {
        peopleArray = getAllItems()
        completion()
    }
    
    func createPerson(firstName: String, lastName: String) {
        database.createPerson(firstName: firstName, lastName: lastName)
    }
    
    func addAddress(personsID: [Int], lat: Double, long: Double) {
        database.addLocation(personsID: personsID, latitude: lat, longitude: long)
    }
    
}

extension MainViewModel {
    
    func resetAllSelection() {
        for index in 0..<peopleArray.count {
            peopleArray[index].unSelect()
        }
    }
    
}

private extension MainViewModel {
    
    func getAllItems() -> [CellViewModel]{
        var peoples: [CellViewModel] = []
        database.getAllItemsAsPersonModel().forEach { person in
            let model = CellViewModel(person: person)
            peoples.append(model)
        }
        return peoples
    }
}


struct CellViewModel {
    var person: PersonModel
    private(set) var isSelected: Bool
    
    init(person: PersonModel) {
        self.person = person
        isSelected = false
    }
    
    mutating func select() {
        isSelected = !isSelected
    }
    
    mutating func unSelect() {
        isSelected = false
    }
    
    
}

