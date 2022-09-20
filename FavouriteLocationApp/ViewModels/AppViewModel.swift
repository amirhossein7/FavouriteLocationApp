//
//  AppViewModel.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation
import CoreLocation

protocol MainViewModelProtocol: AnyObject {
    var peopleArray: ObservableObject<[CellViewModel]> {get}
    var numberOfCells: Int {get}
    var selectedPeoples: [CellViewModel] {get}
    var chosenLocation: CLLocationCoordinate2D {get}
    
    func selectPeople(at indexPath: IndexPath)
    func deletePeople(at indexPath: IndexPath)
    func getCellViewModel(at indexPath: IndexPath) -> CellViewModel
    func reloadData()
    
    func updateChosenLocation(location: CLLocationCoordinate2D)
}

protocol PeopleListViewModelProtocol: AnyObject {
    func createPerson(firstName: String, lastName: String)
    func addAddress(personsID: [Int], lat: Double, long: Double)
}


class AppViewModel {
        
    var database: DatabaseProtocol
    
    var peopleArray: ObservableObject<[CellViewModel]> = ObservableObject([])
    private var location: CLLocationCoordinate2D
    
    
    init(location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)) {
        database = CoreDataService()
        self.location = location
        reloadData()
    }
 
}

// MARK: - Main ViewModel
extension AppViewModel: MainViewModelProtocol {
    
    var chosenLocation: CLLocationCoordinate2D {
        return location
    }
    
    var numberOfCells: Int {
        return peopleArray.value.count
    }
    
    var selectedPeoples: [CellViewModel] {
        return peopleArray.value.filter {$0.isSelected}
    }
    
    func selectPeople(at indexPath: IndexPath) {
        peopleArray.value[indexPath.row].select()
    }
    
    func deletePeople(at indexPath: IndexPath) {
        database.deletePerson(model: peopleArray.value[indexPath.row].person)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CellViewModel {
        return peopleArray.value[indexPath.row]
    }
    
    func reloadData() {
        peopleArray.value = getAllItems()
    }
    
    func updateChosenLocation(location: CLLocationCoordinate2D) {
        self.location = location
    }
    
    func resetAllSelection() {
        for index in 0..<peopleArray.value.count {
            peopleArray.value[index].unSelect()
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
