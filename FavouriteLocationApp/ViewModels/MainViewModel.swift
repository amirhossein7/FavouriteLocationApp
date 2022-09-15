//
//  MainViewModel.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation

class MainViewModel {
        
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
    
    
}
