//
//  AppViewModel.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation
import CoreLocation

protocol MainViewModelProtocol: AnyObject {
    var numberOfCells: Int {get}
    var selectedPeoples: [CellViewModel] {get}
    var chosenLocation: CLLocationCoordinate2D {get}
    
    func selectPeople(at indexPath: IndexPath)
    func getCellViewModel(at indexPath: IndexPath) -> CellViewModel
    func reloadData(completion: () -> ())
    
    func updateChosenLocation(location: CLLocationCoordinate2D)
}

protocol PeopleListViewModelProtocol: AnyObject {
    func createPerson(firstName: String, lastName: String)
    func addAddress(personsID: [Int], lat: Double, long: Double)
}


class AppViewModel {
        
    var database: DatabaseProtocol
    
    private var peopleArray: [CellViewModel] = []
    private var location: CLLocationCoordinate2D
    
    
    init(location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)) {
        database = CoreDataService()
        self.location = location
        peopleArray = getAllItems()
    }
 
}

// MARK: - Main ViewModel
extension AppViewModel: MainViewModelProtocol {
    
    var chosenLocation: CLLocationCoordinate2D {
        return location
    }
    
    var numberOfCells: Int {
        return peopleArray.count
    }
    
    var selectedPeoples: [CellViewModel] {
        return peopleArray.filter {$0.isSelected}
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
    
    func updateChosenLocation(location: CLLocationCoordinate2D) {
        self.location = location
    }
    
    func resetAllSelection() {
        for index in 0..<peopleArray.count {
            peopleArray[index].unSelect()
        }
    }

}

// MARK: - PeopleList ViewModel
extension AppViewModel: PeopleListViewModelProtocol {
    
    func createPerson(firstName: String, lastName: String) {
        database.createPerson(firstName: firstName, lastName: lastName)
    }
    
    func addAddress(personsID: [Int], lat: Double, long: Double) {
        database.addLocation(personsID: personsID, latitude: lat, longitude: long)
    }
    
}

private extension AppViewModel {
    
    func getAllItems() -> [CellViewModel]{
        var peoples: [CellViewModel] = []
        database.getAllItemsAsPersonModel().forEach { person in
            let model = CellViewModel(person: person)
            peoples.append(model)
        }
        return peoples
    }
}
